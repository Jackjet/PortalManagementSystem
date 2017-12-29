using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.HZNW.Category
{
    public partial class DepartmentBeforeList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request.QueryString["id"];
        }
    }
}