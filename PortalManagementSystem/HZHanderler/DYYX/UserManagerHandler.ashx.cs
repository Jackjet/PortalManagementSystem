using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMSHanderler.DYYX
{
    /// <summary>
    /// UserManagerHandler 的摘要说明
    /// </summary>
    public class UserManagerHandler : IHttpHandler
    {
        #region 字段

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        PMSBLL.UserInfoService BllUIS = new PMSBLL.UserInfoService();

        #endregion

        #region 中心入口点

        public void ProcessRequest(HttpContext context)
        {
              try
            {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetPageList": GetPageList(context); break;
                    case "EditUserInfo": EditUserInfo(context); break;
                    case "UpdateUserInfo": UpdateUserInfo(context); break;
                    case "GetUserInfo": GetUserInfo(context); break;
                    case "Login": Login(context); break;
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

        #region 获得用户列表

        /// <summary>
        /// 获得用户列表
        /// </summary>
        /// <param name="context"></param>
        public void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "UserInfo");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["RoleId"])) where += " and RoleId=" + context.Request["RoleId"];
                where += " and IsDelete =" + (int)PMSUtility.SysStatus.正常;
                PMSModel.JsonModel Model = BllUIS.GetPage(ht, true, where);
               
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

        #region 修改用户信息

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="context"></param>
        public void EditUserInfo(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
           
            try
            {
                string Id = context.Request["Id"];
                string LoginName = context.Request["LoginName"];
                string LoginPassword = context.Request["LoginPassword"];
                string RoleId = context.Request["RoleId"];
                PMSModel.UserInfo info = new PMSModel.UserInfo();
                if (!string.IsNullOrWhiteSpace(LoginPassword)) info.LoginPassword = EncryptHelper.Md5By32(LoginPassword);
                info.RoleId = Convert.ToInt32(RoleId);
                if (!string.IsNullOrWhiteSpace(Id))
                {
                    info.Id = int.Parse(context.Request["Id"]);
                    jsonModel = BllUIS.Update(info);
                }
                else
                {
                    List<PMSModel.UserInfo> ui = BllUIS.GetEntityListByField("LoginName", LoginName).retData as List<PMSModel.UserInfo>;
                    if (ui != null && ui.Count > 0)
                    {
                        jsonModel = new PMSModel.JsonModel()
                        {
                            errMsg = "exist",
                            retData = "",
                            status = "no"
                        };
                    }
                    else
                    {
                        info.LoginName = LoginName;
                        info.CreateTime = DateTime.Now;
                        info.IsDelete = (int)PMSUtility.SysStatus.正常;
                        jsonModel = BllUIS.Add(info);
                    }
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

        #region 更新用户信息

        /// <summary>
        /// 更新用户信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdateUserInfo(HttpContext context)
        {
            if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
            {
               
                try
                {
                    PMSModel.UserInfo advert = BllUIS.GetEntityById(int.Parse(context.Request["Id"])).retData as PMSModel.UserInfo;
                    if (advert != null)
                    {
                        if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                            advert.IsDelete = Convert.ToByte(context.Request["IsDelete"]);

                        PMSModel.JsonModel jsonModel = BllUIS.Update(advert);
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

        #region 获得用户信息

        /// <summary>
        /// 获得用户信息
        /// </summary>
        /// <param name="context"></param>
        public void GetUserInfo(HttpContext context)
        {
            string Id = context.Request["Id"];
           
            try
            {
                if (!string.IsNullOrWhiteSpace(Id))
                {
                    PMSModel.UserInfo ui = new PMSModel.UserInfo();
                    PMSModel.JsonModel jsonModel = BllUIS.GetEntityById(int.Parse(Id));
                    if (jsonModel.retData != null)
                    {
                        ui = jsonModel.retData as PMSModel.UserInfo;
                        jsonModel.retData = ui;
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

        #region 登录

        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="context"></param>
        public void Login(HttpContext context)
        {
           
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();               
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["LoginName"]) && !string.IsNullOrWhiteSpace(context.Request["LoginPassword"]))
                {
                    string pwd = EncryptHelper.Md5By32(context.Request["LoginPassword"]);
                    ht.Add("LoginName", context.Request["LoginName"]);
                    ht.Add("LoginPassword", pwd);                                  
                    jsonModel = BllUIS.GetPage(ht, false, where);
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }
                else
                {
                    jsonModel = new PMSModel.JsonModel()
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

    }
}