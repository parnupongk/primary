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
    public partial class bh_rams : System.Web.UI.Page
    {
        public string str_yw = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataReader obj_yw = PPH_MAIN.get_yw(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
            if (obj_yw.HasRows)
            {
                obj_yw.Read();
                str_yw = obj_yw["dateweek"].ToString();
                hidYW.Value = obj_yw["dateweek"].ToString();
                obj_yw.Close();
            }
            
        }
        protected void AjaxFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            string fileName = "bh_rams_" + DateTime.Now.ToString("yyyMMddHHss") + new Random().Next(999) + e.ContentType;// +e.FileName;
            string fullPath = Server.MapPath(ConfigurationManager.AppSettings["PH_FolderUpload"] + fileName);
            AjaxFileUpload.SaveAs(fullPath);
            Session["fileName"] = fullPath;
            Session["showCount"] = "";
            //msgInsert.Text = Session["showCount"].ToString();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["fileName"] != null)
            {
                
                if (InsertData(Session["fileName"].ToString()))
                {
                    Response.Write("<script>alert('Import Data Successfu');</script>");
                    msgInsert.Text = Session["showCount"].ToString();
                }
                else
                {
                    Response.Write("<script>alert('Import Data Not Successful');</script>");
                    msgInsert.Text = "";
                }
            }
            else
            {
                msgInsert.Text = "";
            }
        }

        private bool InsertData(string path)
        {
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
                string sql = "select * from "+firstSheetName+"";
                OleDbCommand cmd = new OleDbCommand(sql, conn);
                OleDbDataReader drRead = cmd.ExecuteReader();
                while (drRead.Read())
                {
                    if (drRead[1].ToString() != "" && drRead[2].ToString() != "")
                    {
                        countAll++;
                        if (hidYW.Value.ToString().Substring(0, 4) == drRead[2].ToString() && hidYW.Value.ToString().Substring(4, 2) == drRead[1].ToString())
                        {
                            if (PPH_BH.insert_rams(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], drRead[0].ToString(), drRead[1].ToString(), drRead[2].ToString(), drRead[3].ToString(), drRead[4].ToString(), drRead[5].ToString(), drRead[6].ToString(), drRead[7].ToString(), drRead[8].ToString(), drRead[9].ToString(), drRead[10].ToString(), drRead[11].ToString(), drRead[12].ToString(), drRead[13].ToString(), Session["fileName"].ToString(), Session["s_userID"].ToString()) == true)
                            {
                                countInsert++;
                            }
                        }
                    }

                }
                Session["showCount"] = countInsert + " From " + countAll + " Rows Inserted ";
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