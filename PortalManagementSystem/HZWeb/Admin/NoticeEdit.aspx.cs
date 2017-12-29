﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.Admin
{
    public partial class NoticeEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NoticeId.Value = Request.QueryString["Id"];
            MenuId.Value = Request.QueryString["MenuId"];
            StarDate.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}