using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQYZ.SitePages
{
    public partial class SearchContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string key = Request.QueryString["key"];
            if (ParameterValidate.IsValidInput(ref key))
            {
                Hkey.Value = key;
            }
        }
    }
}