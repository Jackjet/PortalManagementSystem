using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class AfterVideoEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request.QueryString["id"];
            HAdvertId.Value = Request.QueryString["advId"];
            StarDate.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}