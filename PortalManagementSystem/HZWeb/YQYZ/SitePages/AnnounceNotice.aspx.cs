using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQYZ.SitePages
{
    public partial class AnnounceNotice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (ParameterValidate.IsNumber(id))
            {
                HMenuId.Value = id;
            }
            string advId = Request.QueryString["advId"];
            if (ParameterValidate.IsNumber(advId))
            {
                HAdvId.Value = advId;
            }
        }
    }
}