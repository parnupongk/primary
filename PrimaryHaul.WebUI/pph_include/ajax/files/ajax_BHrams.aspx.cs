﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;
using PPH_SC;

namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class ajax_BHrams : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!string.IsNullOrEmpty(Request.Form["varDP"] as string))
            {
                if (Request.Form["varDP"].ToString() == "3")
                {
                    if (PPH_BH.delete_rams(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], Request.Form["var01"].ToString()))
                    {
                        Response.Write("1");
                    }
                    else
                    {
                        Response.Write("0");
                    }
                }
                if (Request.Form["varDP"].ToString() == "4")
                {
                    if (PPH_BH.rams_rollback(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], Request.Form["var01"].ToString()))
                    {
                        Response.Write("1");
                    }
                    else
                    {
                        Response.Write("0");
                    }
                }
            }
        }
    }
}