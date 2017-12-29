using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMSHanderler.DYYX
{
    /// <summary>
    /// SchoolStyleHandler 的摘要说明
    /// </summary>
    public class SchoolStyleHandler : IHttpHandler
    {
        #region 字段

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        PMSBLL.SchoolStyleService BllSSS = new PMSBLL.SchoolStyleService();


        
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
                    case "UpdateSchoolStyle": UpdateSchoolStyle(context); break;
                    case "EditSchoolStyle": EditSchoolStyle(context); break;
                    case "GetDataInfo": GetDataInfo(context); break;
                    //case "GetSchoolStyle": GetSchoolStyle(context); break;
                        
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

        #region 获取schoolstyle的数据
        
        public void GetPageList(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                var isPage = true;
                if (!string.IsNullOrWhiteSpace(request["PageIndex"])) ht.Add("PageIndex", request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(request["PageSize"])) ht.Add("PageSize", request["PageSize"].ToString());
                ht.Add("TableName", "SchoolStyle");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(request["MenuId"])) where += " and MenuId=" + request["MenuId"];
                if (!string.IsNullOrWhiteSpace(request["isPage"])) isPage = Convert.ToBoolean(request["isPage"]);
                where += " and IsDelete !=" + (int)SysStatus.删除;
                ht.Add("Order", " SortId desc,CreateTime desc ");
                PMSModel.JsonModel Model = BllSSS.GetPage(ht, isPage, where);
               
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

        #region 编辑schoolstyle的数据
        
        public void EditSchoolStyle(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            HttpRequest request = context.Request;
            try
            {
                string Title = request["Title"];
                string ShowImgUrl = request["ImageUrl"];
                PMSModel.SchoolStyle sn = new PMSModel.SchoolStyle();
                sn.ImageUrl = ShowImgUrl;
                sn.Title = Title;
                sn.Description = HttpUtility.UrlDecode(request["Description"]);
                string CreativeHTML = sn.Description;
                sn.FileName = request["FileName"];
                sn.FilePath = request["FilePath"];
                if (Convert.ToBoolean(request["isImgScoll"]))
                {
                    sn.SortId = string.IsNullOrWhiteSpace(request["SortId"]) ? 0 : Convert.ToInt32(request["SortId"]);
                }
                else
                {
                    if (!string.IsNullOrWhiteSpace(request["SortId"])) sn.SortId = Convert.ToInt32(request["SortId"]);
                }
                
                if (CreativeHTML.ToUpper().IndexOf("SRC") > -1)
                {
                    string[] imageArry = new HtmlImgRegex().GetHtmlImageUrlList(CreativeHTML);
                    string imgstr = "";
                    for (int i = 0; i < imageArry.Length; i++)
                    {
                        imgstr += imageArry[i] + ",";
                    }
                    if (imgstr.Length > 0)
                    {
                        sn.ImageUrl = imgstr.Substring(0, imgstr.Length - 1);
                    }
                }
                else
                {
                    sn.ImageUrl = "";
                }
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    int Id = int.Parse(request["Id"]);

                    sn.Id = Id;
                    jsonModel = BllSSS.Update(sn);
                }
                else
                {
                    DateTime CreateTime = DateTime.Now;
                    if (!string.IsNullOrWhiteSpace(request["Creator"])) sn.Creator = request["Creator"];
                    int IsDelete = Convert.ToInt16(SysStatus.正常);
                    sn.MenuId = int.Parse(request["MenuId"]);
                    sn.CreateTime = CreateTime;

                    sn.IsDelete = Convert.ToByte(IsDelete);
                    jsonModel = BllSSS.Add(sn);

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

        #region 更改schoolstyle的数据
        
        public void UpdateSchoolStyle(HttpContext context)
        {
            HttpRequest request = context.Request;
            if (!string.IsNullOrWhiteSpace(request["Id"]))
            {
               
                try
                {
                    PMSModel.SchoolStyle sn = BllSSS.GetEntityById(int.Parse(request["Id"])).retData as PMSModel.SchoolStyle;
                    if (sn != null)
                    {
                        if (!string.IsNullOrWhiteSpace(request["IsDelete"]))
                            sn.IsDelete = Convert.ToByte(request["IsDelete"]);
                        if (!string.IsNullOrWhiteSpace(request["ShowImgUrl"]) && "delImg" == request["ShowImgUrl"])
                            sn.ImageUrl = "";
                        PMSModel.JsonModel jsonModel = BllSSS.Update(sn);
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

        #region 获取其中一条数据
        
        public void GetDataInfo(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                PMSModel.JsonModel Model = new PMSModel.JsonModel();
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    Model = BllSSS.GetEntityById(int.Parse(request["Id"]));
                }
               
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

        #region 根据菜单子节点和父节点获得菜单下的分类信息（以及不包括那些节点NotItem）
        
        ///// <summary>
        ///// 根据菜单子节点和父节点获得菜单下的分类信息（以及不包括那些节点NotItem）
        ///// </summary>
        ///// <param name="context"></param>
        //public void GetSchoolStyle(HttpContext context)
        //{
        //    HttpRequest request = context.Request;
        //    PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
        //    try
        //    {
        //        HashtableCustom ht = new HashtableCustom();
        //        if (!Null_Check(request, "MenuId"))
        //        {

        //            jsonModel = BllSSS.GetEntityListByField("MenuId", request["MenuId"]);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        jsonModel = new PMSModel.JsonModel()
        //        {
        //            errMsg = ex.Message,

        //        };
        //    }
        //    finally
        //    {
        //        context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
        //    }

        //}

        #endregion

        #region 检测是否为null

        static bool Null_Check(HttpRequest request, string key)
        {
            bool result = true;
            try
            {
                if (!string.IsNullOrWhiteSpace(request[key]))
                    result = false;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
            return result;
        }

        #endregion

    }
}