﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMSWeb.HZZS.Sitepages
{
    public partial class BeforeList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HMenuId.Value = Request.QueryString["id"];
        }
    }
}