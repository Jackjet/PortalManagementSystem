using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.ZZMH.Sitepages
{
    public partial class BeforeView : BaseCss
    {
        public string SysWeb = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request["id"];
            HAdvId.Value = Request["advId"];
            //selectPid.Value = Request["selectPid"];
            HSSId.Value = Request["ssId"];

        }
    }
}