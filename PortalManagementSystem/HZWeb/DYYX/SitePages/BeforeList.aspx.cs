using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.DYYX.SitePages
{
    public partial class BeforeList : BaseCss
    {
        public string SysWeb = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request.QueryString["id"];
            
        }
    }
}