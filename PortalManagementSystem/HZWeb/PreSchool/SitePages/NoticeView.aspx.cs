using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.PreSchool.SitePages
{
    public partial class NoticeView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HAdvId.Value = Request.QueryString["advId"];
            HMenuId.Value = Request.QueryString["id"];
        }
    }
}