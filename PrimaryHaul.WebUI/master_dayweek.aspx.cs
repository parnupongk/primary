﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Configuration;
using System.Data.OleDb;
using PrimaryHaul.WebUI.App_Code;
using PrimaryHaul_WS;

namespace PrimaryHaul.WebUI
{
    public partial class master_dayweek : System.Web.UI.Page
    {
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

        }


        protected void AjaxFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            string fileName = "dateweek"+DateTime.Now.ToString("yyyMMddHHss") + new Random().Next(999) + e.ContentType;// +e.FileName;
            string fullPath = Server.MapPath(ConfigurationManager.AppSettings["PH_FolderUpload"] + fileName);
            AjaxFileUpload.SaveAs(fullPath);
            Session["fileName"] = fullPath;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["fileName"] != null)
            {
                if (InsertData(Session["fileName"].ToString()))
                {
                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('Import Data Successful');", true);
                    Response.Write("<script>alert('Import Data Successful');</script>");
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", "alertMessage('Import Data Not Successful');", true);
                    Response.Write("<script>alert('Import Data Not Successful');</script>");
                }
            }
        }

        private bool InsertData(string path)
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[] { new DataColumn("Year"), new DataColumn("Tesco_WK"), new DataColumn("Period_StartDate"), new DataColumn("Period_EndDate"), new DataColumn("Tesco_FY"), new DataColumn("Tesco_Period") });
            //Response.Write(path);
            main_function PPHfunction = new main_function();
        
            string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + path + " ; Extended Properties=Excel 8.0;";
            string connectionStringXLSX = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source= " + path + " ; Extended Properties=\"Excel 12.0;IMEX=1;HDR=Yes;TypeGuessRows=0;ImportMixedTypes=Text\"";

            connectionString = (path.IndexOf("xlsx") > 0) ? connectionStringXLSX : connectionString;

            OleDbConnection conn = new OleDbConnection(connectionString);
            if (conn.State == ConnectionState.Open) conn.Close();
            conn.Open();

            try
            {
                #region Insert

                string sql = "select * from [DateWeek$]";
                OleDbCommand cmd = new OleDbCommand(sql, conn);
                OleDbDataReader drRead = cmd.ExecuteReader();
                while (drRead.Read())
                {
                    if (drRead[0].ToString() != "" && drRead[1].ToString() != "")
                    {
                        string strBetweenS, strBetweenE, strBetween;
                        string[] arrSDate = drRead[2].ToString().Split('/'); strBetweenS = arrSDate[1] + " " + PPHfunction.chrShortMonth(arrSDate[0]) + " " + arrSDate[2].Substring(2, 2);
                        string[] arrESDate = drRead[3].ToString().Split('/'); strBetweenE = arrESDate[1] + " " + PPHfunction.chrShortMonth(arrESDate[0]) + " " + arrESDate[2].Substring(2, 2);
                        string insert_dayweek = drRead[1].ToString();
                        if (insert_dayweek.Length == 1) { insert_dayweek = "0" + insert_dayweek; }
                        strBetween = strBetweenS + " - " + strBetweenE;
                        PPHfunction.QueryExecuteNonQuery("insert into Date_Week_Info (Tesco_Year, Tesco_Week, Period_StartDate, Period_EndDate, Between_Date, Tesco_FY, Tesco_Period) values ('" + drRead[0] + "','" + insert_dayweek + "','" + drRead[2] + "','" + drRead[3] + "','" + strBetween + "', '" + drRead[4] + "', '" + drRead[5] + "')");
                       
                    }

                }

                conn.Close();
                return true;
                #endregion
            }
            catch (Exception ex)
            {
                conn.Close();
                PrimaryHaul_WS.PH_ExceptionManager.WriteError(ex.Message);
                return false;
            }
        }

        
    }
}