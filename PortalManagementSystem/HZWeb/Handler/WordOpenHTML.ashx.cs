using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using WopiService_Proxy;

namespace PMSWeb.Handler
{
    /// <summary>
    /// WordOpenHTML 的摘要说明
    /// </summary>
    public class WordOpenHTML : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                switch (FuncName)
                {
                    case "Wopi_Proxy":
                        Wopi_Proxy1(context);
                        break;
                    default:
                        break;
                }
            }
        }
        private void Wopi_Proxy1(HttpContext context)
        {
            string result = "";
            string filePath = context.Server.MapPath(context.Request["filepath"]);
            string fileFullName = Path.GetFileName(filePath);
            string extension = Path.GetExtension(fileFullName);
            string dateNow = DateTime.Now.ToString("yyyyMMddHHmmss");

            string destFileName = dateNow + extension;
            using (FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            {
                byte[] data = new byte[fs.Length];
                fs.Read(data, 0, data.Length);
                Wopi_Proxy.UploadFile_GetLink(destFileName, data, new Action<string>((link) => { result = link; }));
            }
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