using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQYZ.SitePages
{
    public partial class NoticeList : BaseCss
    {
        public string SysWeb = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (ParameterValidate.IsNumber(id))
            {
                HMenuId.Value = id;
            }
        }
    }
}