using PMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class AfterImgList : System.Web.UI.Page
    {
        public bool isImgScool = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                readXmlPage();
                MenuId.Value = Request.QueryString["id"];
                
            }
            string scool = System.Configuration.ConfigurationManager.AppSettings["ImgScroll"];
            if (MenuId.Value==scool)
            {
                isImgScool = true;
            }
        }


        protected void readXmlPage()
        {
            string xmlpath = "Admin\\SysData.xml";
            string val = XmlHelper.GetValue(xmlpath, "ImgScrollNum");
            scool.Text = val;
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            string xmlpath = "Admin\\SysData.xml";
            XmlHelper.SetValue(xmlpath, "ImgScrollNum", this.scool.Text);
        }
    }
}