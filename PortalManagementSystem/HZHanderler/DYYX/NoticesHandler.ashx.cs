using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMSHanderler.DYYX
{
    /// <summary>
    /// NoticesHandler 的摘要说明
    /// </summary>
    public class NoticesHandler : IHttpHandler
    {
        #region 字段
        
        PMSBLL.System_NoticeService BllSNS = new PMSBLL.System_NoticeService();

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #endregion

        #region 中心入口点
        
        public void ProcessRequest(HttpContext context)
        {
              try
            {
            context.Response.ContentType = "text/plain";
            HttpRequest request = context.Request;
            string action = request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetPageList": GetPageList(context); break;
                    case "UpdateNotice": UpdateNotice(context); break;
                    case "EditNotice": EditNotice(context); break;
                    case "GetNoticeInfo": GetNoticeInfo(context); break;
                }
            }
            else
            {
                context.Response.Write("System Error");
            }
                    }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
        }

        #endregion

        #region 获得新闻通知公告列表

        /// <summary>
        /// 获得新闻通知公告列表
        /// </summary>
        /// <param name="context"></param>
        public void GetPageList(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", request["PageIndex"].ToString());
                ht.Add("PageSize", request["PageSize"].ToString());
                ht.Add("TableName", "System_Notice");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(request["type"]))
                    where += " and [type]=" + request["type"].ToString();
                if (!string.IsNullOrWhiteSpace(request["Root"]))
                    where += " and ([Root]=0 or [Root]=" + request["Root"] + ")";
                if (!string.IsNullOrWhiteSpace(request["isPush"]))
                    where += " and isPush=" + request["isPush"];
                if (!string.IsNullOrWhiteSpace(request["MenuId"]))
                    where += " and MenuId=" + request["MenuId"];
                if (!string.IsNullOrWhiteSpace(request["StarDate"]) && !string.IsNullOrWhiteSpace(request["EndDate"]))
                    where += " and ([CreateTime]>='" + request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + request["EndDate"].ToString() + " 23:59:59')";
                if (!string.IsNullOrWhiteSpace(request["keyWord"]))
                    where += " and (Title+Contents like '%" + request["keyWord"].ToString() + "%')";
                where += " and IsDelete !=" + (int)SysStatus.删除;
                ht.Add("Order", "Hot desc,T.SortId desc,T.CreateTime desc,T.ClickNum asc");
                PMSModel.JsonModel Model = BllSNS.GetPage(ht, true, where);
               
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
               
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 修改新闻通知公告信息
        
        /// <summary>
        /// 修改新闻通知公告信息
        /// </summary>
        /// <param name="context"></param>
        public void EditNotice(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                string Title = request["Title"];
                string Contents = HttpUtility.UrlDecode(request["Contents"]);
                int Hot = int.Parse(request["Hot"]);
                int SortId = request["SortId"] == "" ? 0 : int.Parse(request["SortId"]);
                int ClickNum = request["ClickNum"] == "" ? 0 : int.Parse(request["ClickNum"]);
                int isPush = request["isPush"] == "" ? 0 : int.Parse(request["isPush"]);
                string ShowImgUrl = request["ShowImgUrl"];
                string FileName = request["FileName"];
                string FilePath = request["FilePath"];
                PMSModel.System_Notice sn = new PMSModel.System_Notice();

                sn.ClickNum = ClickNum;
                sn.Contents = Contents;
                sn.Hot = Hot;
                sn.SortId = SortId;
                sn.Title = Title;
                sn.FileName = FileName;
                sn.FilePath = FilePath;
                sn.isPush = isPush;
                sn.CreateTime = string.IsNullOrWhiteSpace(request["CreateTime"]) ? DateTime.Now : Convert.ToDateTime(request["CreateTime"]);
                if (Contents.ToUpper().IndexOf("SRC") > -1)
                {
                    string[] imageArry = new HtmlImgRegex().GetHtmlImageUrlList(Contents);
                    string imgstr = "";
                    for (int i = 0; i < imageArry.Length; i++)
                    {
                        imgstr += imageArry[i] + ",";
                    }
                    if (imgstr.Length > 0)
                    {
                        sn.ShowImgUrl = imgstr.Substring(0, imgstr.Length - 1);
                    }
                }
                else
                {
                    sn.ShowImgUrl = "";
                }
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    int Id = int.Parse(request["Id"]);

                    sn.Id = Id;
                    jsonModel = BllSNS.Update(sn);
                }
                else
                {
                    //DateTime CreateTime = DateTime.Now;
                    string Creator = request["Creator"];
                    int IsDelete = Convert.ToInt16(SysStatus.正常);
                    //sn.CreateTime = CreateTime;
                    sn.Creator = Creator;
                    sn.IsDelete = Convert.ToByte(IsDelete);
                    sn.MenuId = string.IsNullOrWhiteSpace(request["MenuId"]) ? -1 : Convert.ToInt32(request["MenuId"]);
                    jsonModel = BllSNS.Add(sn);

                }
               
                jsonModel.status = "ok";
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
               
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 更新新闻通知公告信息
        
        /// <summary>
        /// 更新新闻通知公告信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdateNotice(HttpContext context)
        {
            HttpRequest request = context.Request;
            if (!string.IsNullOrWhiteSpace(request["Id"]))
            {
               
                try
                {
                    PMSModel.System_Notice sn = BllSNS.GetEntityById(int.Parse(request["Id"])).retData as PMSModel.System_Notice;
                    if (sn != null)
                    {
                        if (!string.IsNullOrWhiteSpace(request["Hot"]))
                            sn.Hot = int.Parse(request["Hot"]);
                        if (!string.IsNullOrWhiteSpace(request["IsDelete"]))
                            sn.IsDelete = Convert.ToByte(request["IsDelete"]);
                        if (!string.IsNullOrWhiteSpace(request["ClickNum"]))
                            sn.ClickNum = sn.ClickNum + 1;
                        if (!string.IsNullOrWhiteSpace(request["isPush"]))
                            sn.isPush = int.Parse(request["isPush"]);
                        PMSModel.JsonModel jsonModel = BllSNS.Update(sn);
                        jsonModel.status = "yes";
                        context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                    }
                }
                catch (Exception ex)
                {
                    LogHelper.Error(ex);
                    PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                        retData = "",
                        status = "no"
                    };
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
        }

        #endregion

        #region 获的新闻通知公告信息
        
        /// <summary>
        /// 获的新闻通知公告信息
        /// </summary>
        /// <param name="context"></param>
        public void GetNoticeInfo(HttpContext context)
        {
            HttpRequest request = context.Request;
            string Id = request["Id"];
           
            try
            {
                if (!string.IsNullOrWhiteSpace(Id))
                {
                    PMSModel.System_Notice sn = new PMSModel.System_Notice();
                    PMSModel.JsonModel jsonModel = BllSNS.GetEntityById(int.Parse(Id));
                    if (jsonModel.retData != null)
                    {
                        sn = jsonModel.retData as PMSModel.System_Notice;
                        jsonModel.retData = sn;
                        context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                    }
                }
                else
                {
                    PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                    {
                        errMsg = "null",
                        retData = "",
                        status = "no"
                    };
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion       
    }
}