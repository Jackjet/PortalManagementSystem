using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQYZ.SitePages
{
    public partial class NoticeView :BaseCss
    {
        public string SysWeb = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string id= Request.QueryString["id"];
            if (ParameterValidate.IsNumber(id)) {
                NoticeId.Value = id;
            }
            string mid= Request.QueryString["mid"];
            if (ParameterValidate.IsNumber(mid))
            {
                HMenuId.Value = mid;
            }
        }
    }
}