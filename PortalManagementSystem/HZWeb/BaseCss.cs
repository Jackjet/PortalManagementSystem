using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMSWeb
{
    public class BaseCss : System.Web.UI.Page 
    {
        public string css { get; set; }
        public BaseCss()
        {

        }
        protected override void OnInit(EventArgs e)
        {
            string sys=System.Configuration.ConfigurationManager.AppSettings["SystemWeb"];
            switch (sys)
            {
                case "DYYX": this.css = "/DYYX/css/layout2.css"; break;
                case "YQYZ": this.css = "/YQYZ/css/layout2.css"; break;
            }
        }
    }
}