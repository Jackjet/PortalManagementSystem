﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.HZNW.SitePages
{
    public partial class BeforeScrollList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request.QueryString["Id"];
            HPMenuId.Value = Request.QueryString["PId"];
            if (!IsPostBack)
            {
                readXml();
            }
        }
        protected void readXml()
        {
            try
            {
                //string xmlpath = "/Admin/SysData.xml";
                //string val = PMSUtility.XmlHelper.GetValue(xmlpath, "RederPages");
                PageNumber.Value = "100";
            }
            catch (Exception)
            {

                PageNumber.Value = "100";
            }

        }
    }
}