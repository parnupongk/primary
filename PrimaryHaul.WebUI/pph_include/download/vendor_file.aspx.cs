﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using PrimaryHaul.WebUI.App_Code;
namespace PrimaryHaul.WebUI.pph_include.download
{
    public partial class vendor_file : System.Web.UI.Page
    {
        public SqlDataReader obj_detail;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + Request.QueryString["VD"].ToString() + "_" + Request.QueryString["YW"].ToString() + ".xls");
        }
    }
}