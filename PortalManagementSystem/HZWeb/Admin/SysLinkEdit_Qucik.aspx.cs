using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class SysLinkEdit_Qucik : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HId.Value = Request.QueryString["Id"];
        }
    }
}