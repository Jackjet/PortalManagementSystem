using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQZJ.Sitepages
{
    public partial class BeforeItemList : BaseCss
    {
        public string SysWeb = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request["Id"];
            HPMenuId.Value = Request["PId"];
            if (!IsPostBack)
            {
                readXml();
            }
        }

        protected void readXml()
        {
            try
            {
                string xmlpath = "/Admin/SysData.xml";
                string val = PMSUtility.XmlHelper.GetValue(xmlpath, "RederPages");
                PageNumber.Value = val;
            }
            catch (Exception)
            {

                PageNumber.Value = "10";
            }
        }
    }
}