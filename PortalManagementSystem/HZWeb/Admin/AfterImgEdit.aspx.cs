using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class AfterImgEdit : System.Web.UI.Page
    {
        public bool isImgScool = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            SchoolId.Value = Request.QueryString["Id"];
            HMenuId.Value = Request.QueryString["MenuId"];
            HImgScroll.Value = System.Configuration.ConfigurationManager.AppSettings["ImgScroll"];
            StarDate.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            if (HImgScroll.Value==HMenuId.Value)
            {
                isImgScool = true;
            }
        }
    }
}