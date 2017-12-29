using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.HZNW.Category
{
    public partial class DepartmentIndex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hspid.Value = Request.QueryString["spid"];
                hidId.Value = Request.QueryString["id"];
            }
        }
    }
}