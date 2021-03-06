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
    public partial class report_venderlog : System.Web.UI.Page
    {
        public SqlDataReader obj_list;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            string sql_list = "Select Date_Week_Info.*  From Date_Week_Info Where wk_id <(select wk_id from Date_Week_Info where Period_StartDate <=Convert(varchar, Getdate(),111) and Period_EndDate >= Convert(varchar, Getdate(),111)) order by Tesco_Year+Tesco_week Desc";
            SqlCommand rs_list = new SqlCommand(sql_list, objConn);
            obj_list = rs_list.ExecuteReader();
        }
    }
}