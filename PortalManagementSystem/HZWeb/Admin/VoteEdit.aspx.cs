using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class VoteEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hidId.Value = Request.QueryString["id"];
                CreateTime.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            }
        }
    }
}