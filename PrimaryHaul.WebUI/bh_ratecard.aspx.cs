using System;
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
using PPH_SC;

namespace PrimaryHaul.WebUI
{
    public partial class bh_ratecard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void AjaxFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            string fileName = "bh_ratecard_" + DateTime.Now.ToString("yyyMMddHHss") + new Random().Next(999) + e.ContentType;// +e.FileName;
            string fullPath = Server.MapPath(ConfigurationManager.AppSettings["PH_FolderUpload"] + fileName);
            AjaxFileUpload.SaveAs(fullPath);
            Session["fileName"] = fullPath;
            Session["showCount"] = "";
            msgInsert.Text = Session["showCount"].ToString();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["fileName"] != null)
            {
                if (InsertData(Session["fileName"].ToString()))
                {
                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('Import Data Successful');", true);
                    Response.Write("<script>alert('Import Data Successful');</script>");
                    msgInsert.Text = Session["showCount"].ToString();
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
            //dt.Columns.AddRange(new DataColumn[] { new DataColumn("Start Date"), new DataColumn("Tesco_WK"), new DataColumn("Period_StartDate"), new DataColumn("Period_EndDate"), new DataColumn("Tesco_FY"), new DataColumn("Tesco_Period") });
 
            string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + path + " ; Extended Properties=Excel 8.0;";
            string connectionStringXLSX = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source= " + path + " ; Extended Properties=\"Excel 12.0;IMEX=1;HDR=Yes;TypeGuessRows=0;ImportMixedTypes=Text\"";
            connectionString = (path.IndexOf("xlsx") > 0) ? connectionStringXLSX : connectionString;
            OleDbConnection conn = new OleDbConnection(connectionString);
            if (conn.State == ConnectionState.Open) conn.Close();
            conn.Open();

            try
            {             
                #region Insert
                DataTable dbSchema = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                if (dbSchema == null || dbSchema.Rows.Count < 1){throw new Exception("Error: Could not determine the name of the first worksheet.");}
                string firstSheetName = dbSchema.Rows[0]["TABLE_NAME"].ToString();
                int countAll = 0, countInsert = 0;
                string sql = "select * from [" + firstSheetName + "]";
                OleDbCommand cmd = new OleDbCommand(sql, conn);
                OleDbDataReader drRead = cmd.ExecuteReader();
                while (drRead.Read())
                {
                    if (drRead[0].ToString() != "")
                    {
                        countAll++;

                        if (PPH_BH.insert_ratecard(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], drRead[1].ToString(), drRead[0].ToString(), drRead[2].ToString(), drRead[3].ToString(), drRead[4].ToString(), drRead[5].ToString(), drRead[6].ToString(), drRead[7].ToString(), drRead[8].ToString(), drRead[9].ToString(), drRead[10].ToString()) == true)
                        {
                            countInsert++;
                        }
                    }

                }
                Session["showCount"] = countInsert + " From " + countAll + " Rows Inserted";
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