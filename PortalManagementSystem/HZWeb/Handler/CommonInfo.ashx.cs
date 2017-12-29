using PMSModel;
using PMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMSWeb.Handler
{
    /// <summary>
    /// CommonInfo 的摘要说明
    /// </summary>
    public class CommonInfo : IHttpHandler
    {
        JsonModel jsonModel = null;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "NoticesForKeyWord":
                            NoticesForKeyWord(context);
                            break;
                    }
                }
                catch (Exception ex)
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 404,
                        errMsg = "无此方法",
                        retData = ""
                    };
                }
            }
        }

        public void NoticesForKeyWord(HttpContext context)
        {
            string urlHead = System.Configuration.ConfigurationManager.AppSettings["KeyWord"] + "/Handler/QueryKeyWord.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) param += "&PageSize=" + context.Request["PageSize"];
            string urlbady = "SearchKey=" + context.Request["SearchKey"];
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}