using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class SchoolDeptManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hId.Value = Request.QueryString["id"];
        }
    }
}