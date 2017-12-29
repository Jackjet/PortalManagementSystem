using PMSBLL;
using PMSModel;
using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace PMSHanderler.DYYX
{
    /// <summary>
    /// AdminManagerHandler 的摘要说明
    /// </summary>
    public class AdminManagerHandler : IHttpHandler
    {
        #region 字段

        AdminManagerService BllAMS = new AdminManagerService();
        System_LinkService BllLS = new System_LinkService();
        PortalTreeDataService BllPTDS = new PortalTreeDataService();
        RoleManagerService BLLRMS = new RoleManagerService();
        System_VoteService BllSVS = new System_VoteService();
        System_VoteDetailsService BllSVDS = new System_VoteDetailsService();
        System_VoteRecordService BllVRS = new System_VoteRecordService();

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
                        //门户后台左侧菜单
                        case "GetLeftNavigationMenu": GetLeftNavigationMenu(context); break;
                        case "GetNavigationMenu": GetNavigationMenu(context); break;
                        case "EditPortalTreeData": EditPortalTreeData(context); break;
                        case "UpdatePortalTreeData": UpdatePortalTreeData(context); break;
                        case "GetPortalTreeData": GetPortalTreeData(context); break;
                        case "GetPortalTreeDataForChildId": GetPortalTreeDataForChildId(context); break;
                        case "GetPortalTreeDataForParentId": GetPortalTreeDataForParentId(context); break;
                        case "GetPortalChildTreeDataForParentId": GetPortalChildTreeDataForParentId(context); break;
                        case "GetBeforeMenu": GetBeforeMenu(context); break;
                        case "GetMenuParent": GetMenuParent(context); break;
                        case "GetTreeOfRole": GetTreeOfRole(context); break;
                        case "GetChildMenuForId": GetChildMenuForId(context); break;
                        case "GetLevelTreeForId": GetLevelTreeForId(context); break;
                        case "GetTreeDataForIdOrPId": GetTreeDataForIdOrPId(context); break;

                        case "GetLinkList": GetLinkList(context); break;
                        case "UpdateLink": UpdateLink(context); break;
                        case "GetLink": GetLink(context); break;
                        case "EditLink": EditLink(context); break;
                        case "GetLinkList_QUICK": GetLinkList_QUICK(context); break;


                        case "GetVoteList": GetVoteList(context); break;
                        case "EditVote": EditVote(context); break;
                        case "UpdateVote": UpdateVote(context); break;
                        case "GetVoteInfo": GetVoteInfo(context); break;
                        case "GetVoteDetailList": GetVoteDetailList(context); break;

                        case "GetVoteDetailInfo": GetVoteDetailsInfo(context); break;
                        case "EditVoteDetail": EditVoteDetail(context); break;
                        case "UpdateVoteDetail": UpdateVoteDetail(context); break;
                        case "EditVoteRecord": EditVoteRecord(context); break;
                        case "VoteSignUp": VoteSignUp(context); break;


                        case "GetPortalTreeDataByPId": GetPortalTreeDataByPId(context); break;
                        case "GetPortalTreeDataById": GetPortalTreeDataById(context); break;
                        case "GetNavicateLeftAboutRead": GetNavicateLeftAboutRead(context); break;
                        case "UpdatePortalTreeDataAboutStyleAndDispalyCount": UpdatePortalTreeDataAboutStyleAndDispalyCount(context); break;

                        case "SetSystemSetting":
                            this.SetSystemSetting(context);
                            break;

                        case "ReadXmlPage":
                            this.ReadXmlPage(context);
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }

        }

        #endregion

        #region 门户后台左侧菜单

        /// <summary>
        /// 门户后台左侧菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetLeftNavigationMenu(HttpContext context)
        {

            try
            {
                Hashtable ht = new Hashtable();
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
                HttpRequest request = context.Request;
                bool isParam = false;
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                    ht.Add("Display", request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["IsDelete"])))
                    ht.Add("IsDelete", request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["BeforeAfter"])))
                    ht.Add("BeforeAfter", request["BeforeAfter"]);
                if (!string.IsNullOrWhiteSpace(request["isParam"])) isParam = Convert.ToBoolean(request["isParam"]);
                string creator = request["Creator"];
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                StringBuilder orgJson = new StringBuilder();
                DataRow[] parMenu = null;
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                    parMenu = dt.Select("PId=0 and Display=" + request["Display"]);
                else
                    parMenu = dt.Select("PId=0");
                int RoleId = -1;
                if (!string.IsNullOrWhiteSpace(request["RoleId"])) RoleId = Convert.ToInt32(request["RoleId"]);
                string mids = BLLRMS.GetMenuIdsForRoleId(RoleId);
                if (!string.IsNullOrWhiteSpace(mids))
                {

                    #region

                    for (int i = 0; i < parMenu.Count(); i++)
                    {
                        var compareMId = "," + parMenu[i]["Id"] + ",";
                        if (!mids.Contains(compareMId))
                        {
                            continue;
                        }
                        orgJson.Append("<li>");
                        orgJson.Append("<a class='menuclick' href='#'>" + parMenu[i]["Name"] + "<span class='iconfont icon-icoxiala'></span></a>");
                        DataRow[] subMenu = null;
                        if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                            subMenu = dt.Select(" PId=" + parMenu[i]["Id"] + "and Display=" + request["Display"]);
                        else
                            subMenu = dt.Select(" PId=" + parMenu[i]["Id"]);
                        orgJson.Append("<ul class='submenu' style='display:none;'>");
                        for (int j = 0; j < subMenu.Count(); j++)
                        {
                            var compareChildMId = "," + subMenu[j]["Id"] + ",";
                            if (!mids.Contains(compareChildMId))
                            {
                                continue;
                            }
                            string url = string.Empty;
                            if (Convert.ToInt32(subMenu[j]["BeforeAfter"]) == (int)BeforeAfter.前后台展示)
                            {
                                switch (Convert.ToInt32(request["BeforeAfter"]))
                                {
                                    case (int)BeforeAfter.前台展示:
                                        url = (subMenu[j]["BeforeUrl"]).ToString();
                                        break;
                                    case (int)BeforeAfter.后台展示:
                                        url = (subMenu[j]["AfterUrl"]).ToString();
                                        break;
                                }
                            }
                            else if (Convert.ToInt32(request["BeforeAfter"]) == (int)BeforeAfter.前台展示)
                            {
                                url = (subMenu[j]["BeforeUrl"]).ToString();
                            }
                            else if (Convert.ToInt32(request["BeforeAfter"]) == (int)BeforeAfter.后台展示)
                            {
                                url = (subMenu[j]["AfterUrl"]).ToString();
                            }
                            if (isParam)
                            {
                                if (url.IndexOf("?") > -1)
                                    url += "&";
                                else
                                    url += "?";
                                url += "title=" + subMenu[j]["Name"] + "&ptitle=" + parMenu[i]["Name"];
                            }
                            orgJson.Append("<li><a href='javascript:void(0);' data-src='" + url + "'>" + subMenu[j]["Name"] + "</a></li>");
                        }
                        orgJson.Append("</ul>");
                        orgJson.Append("</li>");
                    }
                    #endregion
                    //输出Json
                    jsonModel = new PMSModel.JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = orgJson.ToString(),
                    };

                }
                else
                {
                    jsonModel = new PMSModel.JsonModel()
                    {
                        errNum = 999,
                        errMsg = "error",
                        retData = orgJson.ToString(),
                    };
                }

                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 菜单管理中菜单

        /// <summary>
        /// 菜单管理中菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetNavigationMenu(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {

                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                    ht.Add("Display", request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["IsDelete"])))
                    ht.Add("IsDelete", request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["BeforeAfter"])))
                    ht.Add("BeforeAfter", request["BeforeAfter"]);
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                List<string> list = new List<string>();
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errNum = 0,
                    errMsg = "success"
                };
                if (dt != null && dt.Rows.Count > 0)
                {
                    list.Add(new BLLCommon().DataTableToJson(dt));
                    jsonModel.retData = list;
                }
                else
                {
                    jsonModel.retData = null;
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 门户前台首页顶部菜单

        /// <summary>
        /// 门户前台首页顶部菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetBeforeMenu(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                    ht.Add("Display", request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["IsDelete"])))
                    ht.Add("IsDelete", request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["BeforeAfter"])))
                    ht.Add("BeforeAfter", request["BeforeAfter"]);
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                StringBuilder orgJson = new StringBuilder();
                DataRow[] parMenu = null;
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                    parMenu = dt.Select("PId=0 and Display=" + request["Display"], "SortId desc");
                else
                    parMenu = dt.Select("PId=0 ", "SortId desc");
                #region
                for (int i = 0; i < parMenu.Count(); i++)
                {
                    string parUrl = string.Empty;
                    if (Convert.ToInt32(parMenu[i]["BeforeAfter"]) == (int)BeforeAfter.前后台展示)
                    {
                        switch (Convert.ToInt32(request["BeforeAfter"]))
                        {
                            case (int)BeforeAfter.前台展示:
                                parUrl = (parMenu[i]["BeforeUrl"]).ToString();
                                break;
                            case (int)BeforeAfter.后台展示:
                                parUrl = (parMenu[i]["AfterUrl"]).ToString();
                                break;
                        }
                    }
                    else if (Convert.ToInt32(request["BeforeAfter"]) == (int)BeforeAfter.前台展示)
                    {
                        parUrl = (parMenu[i]["BeforeUrl"]).ToString();
                    }
                    else if (Convert.ToInt32(request["BeforeAfter"]) == (int)BeforeAfter.后台展示)
                    {
                        parUrl = (parMenu[i]["AfterUrl"]).ToString();
                    }

                    string htmlt = string.Format("<li class='a{0}'> <dl class='xiala'><dt><a SelfID={1}  href=" + parUrl + ">" + parMenu[i]["Name"] + "</a><em></em></dt><dd><div class='lie'><ul class='liea'>", parMenu[i]["Id"], parMenu[i]["Id"]);

                    orgJson.Append(htmlt);
                    DataRow[] subMenu = dt.Select(" PId=" + (parMenu[i]["Id"]).ToString() + " and Display=" + request["Display"]);
                    for (int j = 0; j < subMenu.Count(); j++)
                    {
                        string url = string.Empty;
                        if (Convert.ToInt32(subMenu[j]["BeforeAfter"]) == (int)BeforeAfter.前后台展示)
                        {
                            switch (Convert.ToInt32(request["BeforeAfter"]))
                            {
                                case (int)BeforeAfter.前台展示:
                                    url = (subMenu[j]["BeforeUrl"]).ToString();
                                    break;
                                case (int)BeforeAfter.后台展示:
                                    url = (subMenu[j]["AfterUrl"]).ToString();
                                    break;
                            }
                        }
                        else if (Convert.ToInt32(request["BeforeAfter"]) == (int)BeforeAfter.前台展示)
                        {
                            url = (subMenu[j]["BeforeUrl"]).ToString();
                        }
                        else if (Convert.ToInt32(request["BeforeAfter"]) == (int)BeforeAfter.后台展示)
                        {
                            url = (subMenu[j]["AfterUrl"]).ToString();
                        }
                        orgJson.Append("<li><a href=" + url + ">" + subMenu[j]["Name"] + "</a></li>");
                    }
                    orgJson.Append("</ul></div>  </dd></dl> </li>");
                }



                #endregion

                //特殊节点
                //DataRow[] drSpecial = null;
                //drSpecial = dt.Select("PId=0 and Id=40");
                //for (int i = 0; i < drSpecial.Count(); i++)
                //{

                //    DataRow[] subMenu = dt.Select(" PId=" + (drSpecial[i]["Id"]).ToString() + " and Display=" + request["Display"]);
                //    for (int j = 0; j < subMenu.Count(); j++)
                //    {

                //        orgJson.Append("<li> <dl class='xiala'><dt><a href='#'  onclick=ResponstUrl('" + subMenu[j]["BeforeUrl"] + "')>" + subMenu[j]["Name"] + "</a><em></em></dt><dd><div class='lie'><ul class='liea'>");
                //        orgJson.Append("</ul></div>  </dd></dl> </li>");
                //    }
                //}

                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = orgJson.ToString(),
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");

            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获取下一级节点信息

        /// <summary>
        /// 获取下一级节点信息
        /// </summary>
        /// <param name="context"></param>
        public void GetChildMenuForId(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "PortalTreeData");
                string where = string.Empty;
                bool isPage = false;
                if (!string.IsNullOrWhiteSpace(request["Id"])) where += " and PId=" + request["Id"];
                if (!string.IsNullOrWhiteSpace(request["Display"])) where += " and Display=" + request["Display"];
                if (!string.IsNullOrWhiteSpace(request["IsDelete"])) where += " and IsDelete=" + request["IsDelete"];
                if (!string.IsNullOrWhiteSpace(request["isPage"])) isPage = Convert.ToBoolean(request["isPage"]);
                ht.Add("Order", " SortId desc ,CreateTime desc ");
                PMSModel.JsonModel Model = BllPTDS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 根据菜单ID获得菜单详细

        /// <summary>
        /// 根据菜单ID获得菜单详细
        /// </summary>
        /// <param name="context"></param>
        public void GetPortalTreeData(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    PMSModel.JsonModel jsonModel = BllPTDS.GetEntityById(int.Parse(request["Id"]));
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 根据菜单子集ID获得同级以及父节点的详细列表

        /// <summary>
        /// 根据菜单子集ID获得同级以及父节点的详细列表
        /// </summary>
        /// <param name="context"></param>
        public void GetPortalTreeDataForChildId(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                //指定某个父ID
                if (!string.IsNullOrWhiteSpace(request["MenuId"]))
                    ht.Add("Id", request["MenuId"]);
                //不包含的项
                if (!string.IsNullOrWhiteSpace(request["NotItem"]))
                    ht.Add("NotItem", request["NotItem"]);

                //不包含前端或后端
                if (!string.IsNullOrWhiteSpace(request["BeforeAfterNot"]))
                    ht.Add("BeforeAfterNot", request["BeforeAfterNot"]);

                PMSModel.JsonModel jsonModel = BllAMS.GetPortalTreeDataForChildId(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 通过父ID获取菜单

        /// <summary>
        /// 根据菜单父集ID获得同级以及父节点的详细列表
        /// </summary>
        /// <param name="context"></param>
        public void GetPortalTreeDataForParentId(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                //指定某个父ID
                if (!string.IsNullOrWhiteSpace(request["MenuId"]))
                    ht.Add("Id", request["MenuId"]);

                //不包含的项
                if (!string.IsNullOrWhiteSpace(request["NotItem"]))
                    ht.Add("NotItem", request["NotItem"]);

                //不包含前端或后端
                if (!string.IsNullOrWhiteSpace(request["BeforeAfterNot"]))
                    ht.Add("BeforeAfterNot", request["BeforeAfterNot"]);

                PMSModel.JsonModel jsonModel = BllAMS.GetPortalTreeDataForParentId(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 根据父级菜单找到子菜单（三级节点）以及四级节点

        /// <summary>
        /// 根据父级菜单找到子菜单（三级节点）以及四级节点
        /// </summary>
        /// <param name="context"></param>
        public void GetPortalChildTreeDataForParentId(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = null;
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key("Id", request);
                ht.Add_Key("Display", request);
                ht.Add_Key("IsDelete", request);
                jsonModel = BllAMS.GetMoreChildTree(ht);

            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 根据菜单ID获得同级菜单列表

        /// <summary>
        /// 根据菜单ID获得同级菜单列表
        /// </summary>
        /// <param name="context"></param>
        public void GetLevelTreeForId(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = null;
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key("Id", request);
                ht.Add_Key("Display", request);
                ht.Add_Key("IsDelete", request);
                jsonModel = BllAMS.GetLevelTree(ht);

            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 通过ID获取PID获取菜单

        public void GetTreeDataForIdOrPId(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = null;

            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key("Display", request);
                ht.Add_Key("IsDelete", request);
                if (ht.Add_Key("Id", request))
                {
                    jsonModel = BllAMS.GetPreTreeDataForChildId(ht);
                }
                else if (!string.IsNullOrWhiteSpace(request["pId"]))
                {
                    jsonModel = BllPTDS.GetEntityById(Convert.ToInt32(request["pId"]));
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 添加或编辑节点

        /// <summary>
        /// 添加或编辑节点
        /// </summary>
        /// <param name="context"></param>
        public void EditPortalTreeData(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();


            HttpRequest request = context.Request;

            using (SqlTransaction trans = SQLHelp.BeginTransaction())
            {
                try
                {
                    string Name = request["Name"];
                    string Display = request["Display"];
                    string BeforeUrl = request["BeforeUrl"];
                    string BeforeAfter = request["BeforeAfter"];
                    string AfterUrl = request["AfterUrl"];
                    string SortId = request["SortId"];
                    string EnName = request["EnName"];
                    string PId = request["PId"];

                    PMSModel.PortalTreeData ptd = new PMSModel.PortalTreeData();
                    ptd.Name = Name;
                    ptd.EnName = EnName;
                    ptd.Display = Convert.ToByte(Display);
                    ptd.BeforeAfter = int.Parse(BeforeAfter);
                    ptd.DisplayCount = 8;
                    ptd.DisplayType = "时间";

                    //ptd.IsShowIndex = request["IsShowIndex"];
                    //ptd.ShowIndexSort = request["ShowIndexSort"];
                    //ptd.MenuLevelIndex = request["MenuLevelIndex"];

                    ptd.SortId = string.IsNullOrWhiteSpace(SortId) ? 0 : int.Parse(SortId);

                    string strID = request["Id"];
                    if (!string.IsNullOrWhiteSpace(strID))
                    {
                        ptd.BeforeUrl = BeforeUrl;
                        ptd.AfterUrl = AfterUrl;
                        Hashtable ht = new Hashtable();
                        ptd.Id = int.Parse(request["Id"]);
                        ptd.PId = int.Parse(request["PId"]);


                        jsonModel = BllPTDS.Update(ptd, trans);

                        ht.Add("Id", request["Id"]);
                        DataTable childTb = BllAMS.GetPortalTreeData(ht, trans);
                        if (childTb != null && childTb.Rows.Count > 0)
                        {

                            if (!string.IsNullOrWhiteSpace(Display)) ht.Add("Display", Display);
                            string ids = "";
                            foreach (DataRow row in childTb.Rows)
                            {
                                ids += row["Id"].ToString() + ",";
                            }
                            if (ids != "")
                            {
                                ids = ids.Substring(0, ids.Length - 1);
                                ht.Add("ids", ids);
                            }
                            int number = BllAMS.UpdatePortalTreeData(ht, trans);
                            if (number < 1)
                            {
                                trans.Rollback();
                            }
                        }
                        trans.Commit();
                    }
                    else
                    {

                        ptd.Creator = request["Creator"];
                        ptd.CreateTime = DateTime.Now;
                        ptd.IsDelete = (int)SysStatus.正常;
                        ptd.PId = int.Parse(request["PId"]);
                        jsonModel = BllPTDS.Add(ptd);

                        object refData = jsonModel.retData;

                        string strRefData = jsonModel.retData.ToString();

                        PMSModel.JsonModel jmItem = BllPTDS.GetEntityById(Convert.ToInt32(refData));
                        if (jmItem != null)
                        {
                            PMSModel.PortalTreeData ptData = jmItem.retData as PMSModel.PortalTreeData;
                            if (ptData != null)
                            {
                                string sys = ConfigurationManager.AppSettings["SystemWeb"];
                                if (ptd.PId == 0)
                                {
                                    ptData.BeforeUrl = "/" + sys + "/SitePages/BeforeItemList.aspx?pid=0&id=" + strRefData + "&selectPid=" + ptd.PId;
                                }
                                else
                                {
                                    ptData.BeforeUrl = "/" + sys + "/SitePages/BeforeItemList.aspx?id=" + strRefData + "&selectPid=" + ptd.PId;

                                }
                                ptData.AfterUrl = "/Admin/AfterList.aspx?id=" + strRefData;

                                ptData.Id = int.Parse(strRefData);
                                PMSModel.JsonModel upJm = BllPTDS.Update(ptData, trans);
                            }
                        }
                        trans.Commit();
                    }
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
                catch (Exception ex)
                {
                    LogHelper.Error(ex);
                    trans.Rollback();
                    jsonModel = new PMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                    };
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
        }

        #endregion

        #region 更新节点信息

        /// <summary>
        /// 更新节点信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdatePortalTreeData(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {

                    PMSModel.PortalTreeData ptd = BllPTDS.GetEntityById(int.Parse(request["Id"])).retData as PMSModel.PortalTreeData;
                    if (ptd != null)
                    {
                        if (!string.IsNullOrWhiteSpace(request["Name"]))
                            ptd.Name = request["Name"];
                        if (!string.IsNullOrWhiteSpace(request["IsDelete"]))
                            ptd.IsDelete = Convert.ToByte(request["IsDelete"]);
                        PMSModel.JsonModel jsonModel = BllPTDS.Update(ptd);
                        context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                    }
                    else
                    {
                        PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                        {
                            errMsg = "null",
                        };
                        context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region  遍历新闻导读排序集合（所有父节点）

        /// <summary>
        /// 遍历新闻导读排序集合（所有父节点）
        /// </summary>
        /// <param name="context"></param>
        public void GetMenuParent(HttpContext context)
        {

            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", 1);
                ht.Add("PageSize", 100);
                ht.Add("@Display", ((int)Display.显示).ToString());
                ht.Add("@BA", ((int)BeforeAfter.前后台展示).ToString());
                ht.Add("@BeforeAfter", ((int)BeforeAfter.前台展示).ToString());
                PMSModel.JsonModel jsonModel = BllAMS.GetMenuParent(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获得角色与节点信息

        /// <summary>
        /// 获得角色与节点信息
        /// </summary>
        /// <param name="context"></param>
        public void GetTreeOfRole(HttpContext context)
        {

            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                //if (!string.IsNullOrWhiteSpace(request["RoleId"])) ht.Add("RoleId", request["RoleId"]);
                jsonModel = BllAMS.GetTreeOfRole(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        //友情链接
        #region 获得友情链接

        /// <summary>
        /// 获得友情链接
        /// </summary>
        /// <param name="context"></param>
        public void GetLinkList(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                string where = "";
                if (!string.IsNullOrWhiteSpace(request["PageIndex"])) ht.Add("PageIndex", request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(request["PageSize"])) ht.Add("PageSize", request["PageSize"].ToString());
                if (!string.IsNullOrWhiteSpace(request["IsOneNav"]))//是否根据一级导航分类
                {
                    ht.Add("TableName", "(select link.*,nav.Name as OneNavName from System_Link link left join PortalTreeData nav on link.OneNavId=nav.Id)"); 
                }
                else
                {
                    ht.Add("TableName", "System_Link");
                }                  
                
                if (!string.IsNullOrWhiteSpace(request["StarDate"]) && !string.IsNullOrWhiteSpace(request["EndDate"]))
                    where += " and ([CreateTime]>='" + request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + request["EndDate"].ToString() + " 23:59:59')";
                where += " and IsDelete!=" + (int)SysStatus.删除;

                where += " and LinkType=" + (int)LinkType.Firendly;
                if (!string.IsNullOrWhiteSpace(request["OneNavId"])) //一级导航Id
                    where += " and OneNavId=" + request["OneNavId"];
                ht.Add("Order", " SortId asc");
                PMSModel.JsonModel Model = BllLS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        /// <summary>
        /// 获得链接（快速通道）
        /// </summary>
        /// <param name="context"></param>
        public void GetLinkList_QUICK(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(request["PageIndex"])) ht.Add("PageIndex", request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(request["PageSize"])) ht.Add("PageSize", request["PageSize"].ToString());
                ht.Add("TableName", "System_Link");
                string where = "";
                if (!string.IsNullOrWhiteSpace(request["StarDate"]) && !string.IsNullOrWhiteSpace(request["EndDate"]))
                    where += " and ([CreateTime]>='" + request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + request["EndDate"].ToString() + " 23:59:59')";
                where += " and IsDelete!=" + (int)SysStatus.删除;

                where += " and LinkType=" + (int)LinkType.Quick;
                ht.Add("Order", " SortId asc");
                PMSModel.JsonModel Model = BllLS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 更新友情链接

        /// <summary>
        /// 更新友情链接
        /// </summary>
        /// <param name="context"></param>
        public void UpdateLink(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    PMSModel.System_Link ptd = BllLS.GetEntityById(int.Parse(request["Id"])).retData as PMSModel.System_Link;
                    if (!string.IsNullOrWhiteSpace(request["IsDelete"]))
                        ptd.IsDelete = Convert.ToByte(request["IsDelete"]);
                    PMSModel.JsonModel jsonModel = BllLS.Update(ptd);
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获得单个友情链接信息

        /// <summary>
        /// 获得单个友情链接信息
        /// </summary>
        /// <param name="context"></param>
        public void GetLink(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    PMSModel.JsonModel jsonModel = BllLS.GetEntityById(int.Parse(request["Id"]));
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 修改友情链接

        /// <summary>
        /// 修改友情链接
        /// </summary>
        /// <param name="context"></param>
        public void EditLink(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                string Id = request["Id"];
                string Title = request["Title"];
                string ImageUrl = request["ImageUrl"];
                string SortId = request["SortId"];
                string Href = request["Href"];




                PMSModel.System_Link sd = new PMSModel.System_Link();
                sd.Title = Title;
                sd.ImageUrl = ImageUrl;
                sd.SortId = int.Parse(SortId);
                sd.Href = Href;
                sd.OneNavId =Convert.ToInt32(request["OneNavId"]??"0");
                //链接类型（友情类型）
                if (!string.IsNullOrEmpty(request["LinkType"]))
                {
                    string LinkType = request["LinkType"];
                    sd.LinkType = Convert.ToInt32(LinkType);
                }

                if (!string.IsNullOrWhiteSpace(Id))
                {
                    sd.Id = int.Parse(Id);
                    jsonModel = BllLS.Update(sd);
                }
                else
                {
                    sd.CreateTime = DateTime.Now;
                    sd.IsDelete = (int)SysStatus.正常;
                    jsonModel = BllLS.Add(sd);
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        //投票
        #region 获得投票列表

        /// <summary>
        /// 获得投票列表
        /// </summary>
        /// <param name="context"></param>
        public void GetVoteList(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                bool isPage = true;
                if (!string.IsNullOrWhiteSpace(request["PageIndex"])) ht.Add("PageIndex", request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(request["PageSize"])) ht.Add("PageSize", request["PageSize"].ToString());
                ht.Add("TableName", "System_Vote");
                string where = "";
                if (!string.IsNullOrWhiteSpace(request["isPush"].SafeToString())) where += " and isPush=" + request["isPush"];
                if (!string.IsNullOrWhiteSpace(request["IsDelete"])) where += " and IsDelete=" + request["IsDelete"];
                if (!string.IsNullOrWhiteSpace(request["isPage"])) isPage = Convert.ToBoolean(request["isPage"]);
                ht.Add("Order", " SortId desc,CreateTime desc");
                PMSModel.JsonModel Model = BllLS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 修改投票信息

        /// <summary>
        /// 修改投票信息
        /// </summary>
        /// <param name="context"></param>
        public void EditVote(HttpContext context)
        {

            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                string id = request["Id"];
                string tilte = request["Title"];
                string desc = HttpUtility.UrlDecode(request["Description"]);
                string sortid = request["SortId"];
                byte isPush = Convert.ToByte(request["isPush"]);
                if (!string.IsNullOrWhiteSpace(id))
                {
                    PMSModel.JsonModel model = BllSVS.GetEntityById(Convert.ToInt32(id));
                    if (model != null)
                    {
                        PMSModel.System_Vote item = model.retData as PMSModel.System_Vote;
                        item.Title = tilte;
                        item.Description = desc;
                        item.SortId = Convert.ToInt64(sortid);
                        jsonModel = BllSVS.Update(item);
                    }
                }
                else
                {
                    PMSModel.System_Vote item = new PMSModel.System_Vote();
                    item.CreateTime = DateTime.Now;
                    item.Description = desc;
                    item.Title = tilte;
                    item.IsDelete = Convert.ToByte((int)SysStatus.正常);
                    item.isPush = isPush;

                    long sourLL;
                    if (long.TryParse(sortid, out sourLL))
                    {
                    }

                    item.SortId = Convert.ToInt64(sourLL);
                    jsonModel = BllSVS.Add(item);
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获得投票信息

        /// <summary>
        /// 获得投票信息
        /// </summary>
        /// <param name="context"></param>
        public void GetVoteInfo(HttpContext context)
        {
            HttpRequest request = context.Request;

            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                string id = request["Id"];
                if (!string.IsNullOrWhiteSpace(id))
                {
                    jsonModel = BllSVS.GetEntityById(Convert.ToInt32(id));
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 更新投票信息

        /// <summary>
        /// 更新投票信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdateVote(HttpContext context)
        {

            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    if (!string.IsNullOrWhiteSpace(request["del"]))
                    {
                        ht.Add("Id", request["Id"]);
                        jsonModel = BllAMS.DelVote(ht);
                    }
                    else
                    {
                        PMSModel.System_Vote sv = new PMSModel.System_Vote();
                        sv = BllSVS.GetEntityById(Convert.ToInt32(request["Id"])).retData as PMSModel.System_Vote;
                        if (sv != null)
                        {
                            if (!string.IsNullOrWhiteSpace(request["isPush"])) sv.isPush = Convert.ToByte(request["isPush"]);
                            if (!string.IsNullOrWhiteSpace(request["isDelete"])) sv.IsDelete = Convert.ToByte(request["isDelete"]);
                            jsonModel = BllSVS.Update(sv);
                        }
                    }
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获得投票选项集合

        /// <summary>
        /// 获得投票选项集合
        /// </summary>
        /// <param name="context"></param>
        public void GetVoteDetailList(HttpContext context)
        {

            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(request["VoteId"])) ht.Add("VoteId", request["VoteId"]);
                jsonModel = BllAMS.GetVoteDetails(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获得投票选项信息

        /// <summary>
        /// 获得投票选项信息
        /// </summary>
        /// <param name="context"></param>
        public void GetVoteDetailsInfo(HttpContext context)
        {

            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    jsonModel = BllSVDS.GetEntityById(Convert.ToInt32(request["Id"]));
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 修改投票选项信息

        /// <summary>
        /// 修改投票选项信息
        /// </summary>
        /// <param name="context"></param>
        public void EditVoteDetail(HttpContext context)
        {

            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    PMSModel.System_VoteDetails svd = BllSVDS.GetEntityById(Convert.ToInt32(request["Id"])).retData as PMSModel.System_VoteDetails;
                    if (svd != null)
                    {
                        svd.Title = request["Title"];
                        jsonModel = BllSVDS.Update(svd);

                    }
                }
                else
                {
                    PMSModel.System_VoteDetails svd = new PMSModel.System_VoteDetails();
                    svd.Title = request["Title"];
                    svd.VoteId = Convert.ToInt32(request["VoteId"]);
                    jsonModel = BllSVDS.Add(svd);
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 更新投票选项信息

        /// <summary>
        /// 更新投票选项信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdateVoteDetail(HttpContext context)
        {
            HttpRequest request = context.Request;

            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                if (!string.IsNullOrWhiteSpace(request["Id"]))
                {
                    jsonModel = BllSVDS.Delete(Convert.ToInt32(request["Id"]));
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 修改投票记录信息

        /// <summary>
        /// 修改投票记录信息
        /// </summary>
        /// <param name="context"></param>
        public void EditVoteRecord(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                string detailId = request["detailId"];
                string ip = IPHelper.GetIP();
                if (!string.IsNullOrWhiteSpace(detailId))
                {
                    PMSModel.System_VoteRecord vr = new PMSModel.System_VoteRecord();
                    vr.Count = 1;
                    vr.DetailsId = Convert.ToInt32(detailId);
                    vr.IP = ip;
                    jsonModel = BllVRS.Add(vr);
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 报名
       
        public void VoteSignUp(HttpContext context)
        {

            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                List<SqlParameter> pms = new List<SqlParameter>();
                pms.Add(new SqlParameter("@VoteId", request["VoteId"]));
                pms.Add(new SqlParameter("@Title", request["Name"]+ "," + request["Phone"]));
                jsonModel = BllSVDS.IsNameExists(" VoteId=@VoteId and Title like N''+@Title+'%' ", pms);                                            
                if (jsonModel.errNum == 0)
                {
                    if (jsonModel.retData.ToString().ToLower() == "true")
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = -1,
                            errMsg = "exist",
                            retData = ""
                        };
                    }
                    else
                    {
                        PMSModel.System_VoteDetails svd = new PMSModel.System_VoteDetails();
                        svd.Title = request["Name"] + "," + request["Phone"] + "," + request["Descript"];
                        svd.VoteId = Convert.ToInt32(request["VoteId"]);
                        jsonModel = BllSVDS.Add(svd);
                    }
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获取导航（用户导读设置）


        /// <summary>
        /// 菜单管理中菜单(用户导读设置）
        /// </summary>
        /// <param name="context"></param>
        public void GetNavicateLeftAboutRead(HttpContext context)
        {

            HttpRequest request = context.Request;
            try
            {

                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["Display"])))
                    ht.Add("Display", request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["IsDelete"])))
                    ht.Add("IsDelete", request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["BeforeAfter"])))
                    ht.Add("BeforeAfter", request["BeforeAfter"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(request["PId"])))
                    ht.Add("PId", request["PId"]);
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                List<string> list = new List<string>();
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errNum = 0,
                    errMsg = "success"
                };
                if (dt != null && dt.Rows.Count > 0)
                {
                    list.Add(new BLLCommon().DataTableToJson(dt));
                    jsonModel.retData = list;
                }
                else
                {
                    jsonModel.retData = null;
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }

        }


        #endregion

        #region 纯粹获取pID为0的父菜单(通知公告、学习天地、最新导读、德育之窗、党建园地)

        public void GetPortalTreeDataByPId(HttpContext context)
        {


            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "PortalTreeData");
                string where = string.Empty;
                bool isPage = false;
                //if (!string.IsNullOrWhiteSpace(request["PId"])) where += " and PId=" + request["PId"];
                if (!string.IsNullOrWhiteSpace(request["Display"])) where += " and Display=" + request["Display"];
                if (!string.IsNullOrWhiteSpace(request["IsDelete"])) where += " and IsDelete=" + request["IsDelete"];

                ht.Add("Order", " SortId desc ,CreateTime desc ");
                PMSModel.JsonModel Model = BllPTDS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 通过ID获取父菜单（每一条栏目显示的条数从此获取）

        public void GetPortalTreeDataById(HttpContext context)
        {


            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "PortalTreeData");
                string where = string.Empty;
                bool isPage = false;
                if (!string.IsNullOrWhiteSpace(request["Id"])) where += " and Id=" + request["Id"];
                if (!string.IsNullOrWhiteSpace(request["Display"])) where += " and Display=" + request["Display"];
                if (!string.IsNullOrWhiteSpace(request["IsDelete"])) where += " and IsDelete=" + request["IsDelete"];

                ht.Add("Order", " SortId desc ,CreateTime desc ");
                PMSModel.JsonModel Model = BllPTDS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }


        #endregion

        #region 更改数据（菜单板块的显示设置和条数显示）

        public void UpdatePortalTreeDataAboutStyleAndDispalyCount(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();


            HttpRequest request = context.Request;

            using (SqlTransaction trans = SQLHelp.BeginTransaction())
            {
                try
                {
                    //保证数据存在
                    if (!string.IsNullOrWhiteSpace(request["Id"]))
                    {
                        PMSModel.PortalTreeData ptd = new PMSModel.PortalTreeData();

                        string DisplayCount = request["DisplayCount"];
                        string DisplayType = request["DisplayType"];

                        Hashtable ht = new Hashtable();
                        ptd.Id = int.Parse(request["Id"]);
                        BllPTDS.Update(ptd, trans);

                        ht.Add("Id", request["Id"]);

                        ht.Add("DisplayCount", DisplayCount);

                        ht.Add("DisplayType", DisplayType);
                        string ids = request["Id"] + ",";
                        DataTable childTb = BllAMS.GetPortalTreeData(ht, trans);
                        if (childTb != null && childTb.Rows.Count > 0)
                        {

                            foreach (DataRow row in childTb.Rows)
                            {
                                ids += row["Id"].ToString() + ",";
                            }
                            if (ids != "")
                            {
                                ids = ids.Substring(0, ids.Length - 1);
                                ht.Add("ids", ids);
                            }
                            int number = BllAMS.UpdatePortalTreeData(ht, trans);
                            if (number < 1)
                            {
                                trans.Rollback();
                            }
                        }
                        trans.Commit();

                        //输出Json
                        jsonModel = new PMSModel.JsonModel()
                        {
                            errNum = 0,
                            errMsg = "success",
                        };
                    }

                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
                catch (Exception ex)
                {
                    LogHelper.Error(ex);
                    trans.Rollback();
                    jsonModel = new PMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                    };
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
        }

        #endregion

        #region 系统设置（滚动设置、）
        System.Web.Script.Serialization.JavaScriptSerializer jss2 = new System.Web.Script.Serialization.JavaScriptSerializer();
        #region 读取数据

        protected void ReadXmlPage(HttpContext context)
        {
            JsonModel jsonModel = new JsonModel();
            HttpRequest request = context.Request;
            try
            {
                SystemInfo systemInfo = new SystemInfo();

                string xmlpath = "SysData.xml";
                systemInfo.NoticeDisplayType = XmlHelper.GetValue(xmlpath, "NoticeDisplayType");
                systemInfo.IsShowNotiecRoll = XmlHelper.GetValue(xmlpath, "IsShowNotiecRoll");
                jsonModel.retData = systemInfo;
                jsonModel.errMsg = "success";

            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = "操作失败";
            }
            finally
            {
                context.Response.Write("{\"result\":" + jss2.Serialize(jsonModel) + "}");
            }

        }

        #endregion

        #region 系统设置

        protected void SetSystemSetting(HttpContext context)
        {
            JsonModel jsonModel = new JsonModel();
            HttpRequest request = context.Request;
            try
            {
                var NoticeDisplayType = Convert.ToString(request["NoticeDisplayType"]);
                var IsShowNotiecRoll = Convert.ToString(request["IsShowNotiecRoll"]);
                if (!string.IsNullOrWhiteSpace(NoticeDisplayType) && !string.IsNullOrWhiteSpace(IsShowNotiecRoll))
                {
                    string xmlpath = "SysData.xml";
                    XmlHelper.SetValue(xmlpath, "NoticeDisplayType", NoticeDisplayType);
                    XmlHelper.SetValue(xmlpath, "IsShowNotiecRoll", IsShowNotiecRoll);
                    jsonModel.errMsg = "success";
                }

            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel.errMsg = "操作失败";
            }
            finally
            {
                context.Response.Write("{\"result\":" + jss2.Serialize(jsonModel) + "}");
            }

        }

        #endregion


        [Serializable]
        public class SystemInfo
        {
            public string NoticeDisplayType { get; set; }
            public string IsShowNotiecRoll { get; set; }
        }

        #endregion
    }
}