using PMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.YQYZ
{
    public partial class Header : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            readXmlPage();
        }

        protected void readXmlPage()
        {
            string xmlpath = "Admin\\SysData.xml";
            string val = XmlHelper.GetValue(xmlpath, "ImgScrollNum");
            scrollNum.Value = string.IsNullOrWhiteSpace(val) ? "3" : val;
        }
    }
}