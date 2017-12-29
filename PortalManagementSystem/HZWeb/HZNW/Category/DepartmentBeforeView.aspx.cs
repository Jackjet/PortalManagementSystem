using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.HZNW.Category
{
    public partial class DepartmentBeforeView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request.QueryString["id"];
            if (string.IsNullOrWhiteSpace(HMenuId.Value)) HMenuId.Value = Request.QueryString["mid"];
            HAdvId.Value = Request.QueryString["advId"];
        }
    }
}