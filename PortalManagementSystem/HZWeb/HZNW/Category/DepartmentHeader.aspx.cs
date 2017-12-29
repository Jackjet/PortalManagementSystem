using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.HZNW.Category
{
    public partial class DepartmentHeader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HTypeName.Value = Request.QueryString["typename"];
            HTypeId.Value = Request.QueryString["typeid"];
            HMId.Value = Request.QueryString["mid"];
            if (!string.IsNullOrWhiteSpace(Request.QueryString["enname"])) HTypeName.Value = Request.QueryString["enname"];
        }
    }
}