﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class haulier_abbrDuplicate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            cs_checkFiled checkDuplicate = new cs_checkFiled();
            int afterCheckDuplicate = checkDuplicate.sql_checkDuplicate("SELECT top 1 Haulier_TaxID FROM Haulier_Info where Haulier_Abbr='" + Request.Form["var01"].ToString() + "'");
            Response.Write(afterCheckDuplicate);
        }
    }
}