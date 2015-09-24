using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class haulier_upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { GetHaulierData(true); }

        }

        private void GetHaulierData(bool isNew)
        {
            try
            {
                if(isNew || ViewState["HaulierUpload"] == null)
                {
                    ViewState["HaulierUpload"] = PH_HaulierUpload.PH_HaulierUp_SelAll(AppCode.strConnDB);
                }


            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError("GetHaulierData >>" + ex.Message);
            }
        }

        protected void AjaxFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            try
            {
                string fileName = "haulier_" + DateTime.Now.ToString("yyyMMddHHss") + new Random().Next(999) + e.ContentType;// +e.FileName;
                string fullPath = Server.MapPath(ConfigurationManager.AppSettings["PH_FolderUpload"] + fileName);
                AjaxFileUpload.SaveAs(fullPath);
                Session["fileName"] = fullPath;
                
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError("AjaxFileUpload_UploadComplete >>" + ex.Message);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                InsertData(Session["fileName"].ToString());
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError("AjaxFileUpload_UploadComplete >>" + ex.Message);
            }
        }
        private void InsertData(string path)
        {
            try {
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[] { new DataColumn("Haulier_Abbr"), new DataColumn("Po_No"), new DataColumn("Delivery_Ref"), new DataColumn("Delivery_Date")
                                                        ,new DataColumn("Vendor_Code"), new DataColumn("Vendor_Name"), new DataColumn("Collection_Point"), new DataColumn("Delivery_Location")
                                                        ,new DataColumn("RateType"), new DataColumn("No_Of_Qty"), new DataColumn("Rate_Per_Uint"), new DataColumn("Currency")
                                                        ,new DataColumn("Addition_Cost"), new DataColumn("Addition_Cost_Reason"), new DataColumn("Total_Cost"), new DataColumn("Year_Week_No")
                                                        ,new DataColumn("Remark1"), new DataColumn("Remark2"), new DataColumn("Fuel_Rate") ,new DataColumn("Trans_Type")
                                                     });

                string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + path + " ; Extended Properties=Excel 8.0;";
                OleDbConnection conn = new OleDbConnection(connectionString);
                if (conn.State == ConnectionState.Open) conn.Close();
                conn.Open();

                try
                {
                    #region Insert
                    bool isErr = false;
                    string sql = "select * from [haulier$]";
                    OleDbCommand cmd = new OleDbCommand(sql, conn);
                    OleDbDataReader drRead = cmd.ExecuteReader();
                    DataView dv = null;
                    GetHaulierData(false);
                    DataTable dtHaulier = (DataTable)ViewState["HaulierUpload"];
                    while (drRead.Read())
                    {
                        dt.Rows.Add(drRead[0], drRead[1], drRead[2], drRead[3]
                                    , drRead[4], drRead[5], drRead[6], drRead[7]
                                    , drRead[8], drRead[9], drRead[10], drRead[11]
                                    , drRead[12], drRead[13], drRead[14], drRead[15]
                                    , drRead[16], drRead[17], drRead[18],"");

                        dt.Rows[dt.Rows.Count - 1][19] = IsErrCaseII(dt.Rows[dt.Rows.Count - 1]); // case II , III ,IV
                        if (IsErrCaseI(dt.Rows[dt.Rows.Count-1],dtHaulier.DefaultView))
                        {
                            isErr = true;
                            dt.Rows[dt.Rows.Count - 1][16] = "Dup";
                        }

                        

                    }
                    gvData.DataSource =dt;
                    gvData.DataBind();
                    if (!isErr) ViewState["HaulierUploadInsert"] = dt;
                    #endregion
                }
                catch(Exception ex)
                {
                    lblErr.Text = ex.Message;
                    PH_ExceptionManager.WriteError("InsertData >>" + ex.Message);
                }

                    }
            catch(Exception ex)
            {
                throw new Exception("InsertData>>" + ex.Message);
            }
        }

        private bool IsErrCaseI(DataRow dr,DataView dv)
        {
            try
            {
                string str = "Haulier_Abbr='" + dr[0] + "' and PO_no='" + dr[1] + "' and Delivery_ref='" + dr[2] + "' and Delivery_date='" + dr[3] + "' ";
                str += "and Vendor_code = '" + dr[4] + "' and Collection_point = '" + dr[6] + "' and Delivery_location = '" + dr[7] + "'";
                str += "and Ratetype = '" + dr[8] + "' and Rate_Per_Unit = '" + dr[10] + "'";
                dv.RowFilter = new System.Text.StringBuilder().Append(str).ToString();

                return dv.Count > 0 ?true:false;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private string IsErrCaseII(DataRow dr)
        {
            try
            {
                string str = "";
                if (dr[1] == null && dr[16].ToString().Trim().ToLower() == "miscellaneous") str = "M";
                else if (dr[1] == null && dr[16].ToString().Trim().ToLower() == "rejecteditems") str = "R";
                else if (dr[1] == null) str = "N";
                else if (dr[5].ToString() == "Dummy" && dr[1].ToString().Trim() == "" && dr[14].ToString().Trim() != "") str = "L";

                return str;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {

        }
    }
}