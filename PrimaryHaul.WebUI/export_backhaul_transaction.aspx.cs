﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI
{
    public partial class export_backhaul_transaction : System.Web.UI.Page
    {
        public string sql_yw = "Select Date_Week_Info.*  From Date_Week_Info Where wk_id <(select wk_id from Date_Week_Info where Period_StartDate <=Convert(varchar, Getdate(),111) and Period_EndDate >= Convert(varchar, Getdate(),111)) order by Tesco_Year+Tesco_week Desc ";
        public string sql_hl = "select * from Haulier_Info order by Haulier_Name_En asc";
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
        }
    }
}