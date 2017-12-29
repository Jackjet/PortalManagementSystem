using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQYZ.SitePages
{
    public partial class BeforeView : BaseCss
    {
        public string SysWeb = "";
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
            string ssId =  Request.QueryString["ssId"];
            if (ParameterValidate.IsNumber(ssId))
            {
                HSSId.Value = ssId;
            }
        }
    }
}