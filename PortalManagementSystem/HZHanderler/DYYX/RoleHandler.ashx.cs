using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMSHanderler.DYYX
{
    /// <summary>
    /// RoleHandler 的摘要说明
    /// </summary>
    public class RoleHandler : IHttpHandler
    {
        #region 字段

        PMSBLL.RoleInfoService BLLRIS = new PMSBLL.RoleInfoService();
        PMSBLL.RoleManagerService BLLRMS = new PMSBLL.RoleManagerService();

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
                    case "EditRoleInfo": EditRoleInfo(context); break;
                    case "UpdateRoleInfo": UpdateRoleInfo(context); break;
                    case "GetRoleInfo": GetRoleInfo(context); break;
                    case "GetMenuIdsForRoleId": GetMenuIdsForRoleId(context); break;
                    case "EditRoleMenu": EditRoleMenu(context); break;
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

        #region 获得角色列表
        
        /// <summary>
        /// 获得角色列表
        /// </summary>
        /// <param name="context"></param>
        public void GetPageList(HttpContext context)
        {
            HttpRequest request = context.Request;
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(request["PageIndex"])) ht.Add("PageIndex", request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(request["PageSize"])) ht.Add("PageSize", request["PageSize"].ToString());
                var isPage = true;
                if (!string.IsNullOrWhiteSpace(request["isPage"])) isPage = Convert.ToBoolean(request["isPage"]);
                ht.Add("TableName", "RoleInfo");
                string where = string.Empty;

                PMSModel.JsonModel Model = BLLRIS.GetPage(ht, isPage, where);
               
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

        #region 修改角色信息
        
        /// <summary>
        /// 修改角色信息
        /// </summary>
        /// <param name="context"></param>
        public void EditRoleInfo(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            HttpRequest request = context.Request;
            try
            {  

                string Id = request["Id"];
                string RoleName = request["RoleName"];
                PMSModel.RoleInfo info = new PMSModel.RoleInfo();
                info.RoleName = RoleName;
                if (!string.IsNullOrWhiteSpace(Id))
                {

                    info.Id = int.Parse(request["Id"]);
                    jsonModel = BLLRIS.Update(info);
                }
                else
                {
                    jsonModel = BLLRIS.Add(info);
                }
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

        #region 更新角色信息
        
        /// <summary>
        /// 更新角色信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdateRoleInfo(HttpContext context)
        {
            HttpRequest request = context.Request;
            if (!string.IsNullOrWhiteSpace(request["Id"]))
            {
               
                try
                {
                    PMSModel.RoleInfo advert = BLLRIS.GetEntityById(int.Parse(request["Id"])).retData as PMSModel.RoleInfo;
                    if (advert != null)
                    {
                        if (!string.IsNullOrWhiteSpace(request["IsDelete"]))
                        {
                            Hashtable ht = new Hashtable();
                            ht.Add("Id", advert.Id);
                            //PMSModel.JsonModel jsonModel = BLLRIS.Delete(Convert.ToInt32(advert.Id));
                            PMSModel.JsonModel jsonModel = BLLRMS.DelRole(ht);
                            jsonModel.status = "yes";
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
                        retData = "",
                        status = "no"
                    };
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
            }
        }

        #endregion

        #region 获取某个角色
        
        /// <summary>
        /// 获得
        /// </summa角色信息ry>
        /// <param name="context"></param>
        public void GetRoleInfo(HttpContext context)
        {
            HttpRequest request = context.Request;
            string Id = request["Id"];
           
            try
            {
                if (!string.IsNullOrWhiteSpace(Id))
                {
                    PMSModel.RoleInfo ri = new PMSModel.RoleInfo();
                    PMSModel.JsonModel jsonModel = BLLRIS.GetEntityById(int.Parse(Id));
                    if (jsonModel.retData != null)
                    {
                        ri = jsonModel.retData as PMSModel.RoleInfo;
                        jsonModel.retData = ri;
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

        #region 根据角色ID获得菜单集合

        /// <summary>
        /// 根据角色ID获得菜单集合
        /// </summary>
        /// <param name="context"></param>
        public void GetMenuIdsForRoleId(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("RoleId", request["RoleId"]);
                jsonModel = BLLRMS.GetMenuIdsForRoleId(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region EditRoleMenu
        
        /// <summary>
        /// 修改角色菜单
        /// </summary>
        /// <param name="context"></param>
        public void EditRoleMenu(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("RoleId", request["RoleId"]);
                ht.Add("MenuIds", request["MenuIds"]);
                jsonModel = BLLRMS.EditRoleMenu(ht);
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion
       
    }
}