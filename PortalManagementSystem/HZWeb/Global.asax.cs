
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace PMSWeb
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            string fullOrigionalpath = Request.Url.ToString();
            if (!string.IsNullOrWhiteSpace(fullOrigionalpath) && fullOrigionalpath.Contains("/admin"))
            {
                int pathIndex = fullOrigionalpath.LastIndexOf("/");
                string path = fullOrigionalpath.Substring(pathIndex);
                if(path.Length<7)Context.RewritePath("~/admin/index.aspx");
            }
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}