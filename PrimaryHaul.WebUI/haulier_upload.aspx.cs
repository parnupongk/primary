﻿using System;
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
using PrimaryHaul_WS.AppCode_DS;
namespace PrimaryHaul.WebUI
{
    public partial class haulier_upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnClear.Enabled = false;
                btnSubmit.Enabled = false;
                btnInsert.Enabled = false;
                GetHaulierData(true);
                lblWeek.Text = PH_HaulierUpload.PH_HaulierUp_GetDateWeek(AppCode.strConnDB);
            }

        }

        private void GetHaulierData(bool isNew)
        {
            try
            {
                if (isNew || ViewState["HaulierUpload"] == null)
                {
                    ViewState["HaulierUpload"] = PH_HaulierUpload.PH_HaulierUp_SelAll(AppCode.strConnDB);
                }


            }
            catch (Exception ex)
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
                btnSubmit.Enabled = true;

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
                ClearView();
                lblErr.Text = "Please wait while verifying";
                InsertData(Session["fileName"].ToString());
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError("verlify data >>" + ex.Message);
            }
        }
        private void InsertData(string path)
        {
            bool isErr = false;

            try
            {

                PHDS_HaulierUpload.TransportationDataTable dtHaulierUp = new PHDS_HaulierUpload.TransportationDataTable();
                /*DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[] { new DataColumn("Haulier_Abbr"), new DataColumn("Po_No"), new DataColumn("Delivery_Ref"), new DataColumn("Delivery_Date")
                                                        ,new DataColumn("Vendor_Code"), new DataColumn("Vendor_Name"), new DataColumn("Collection_Point"), new DataColumn("Delivery_Location")
                                                        ,new DataColumn("RateType"), new DataColumn("No_Of_Qty"), new DataColumn("Rate_Per_Uint"), new DataColumn("Currency")
                                                        ,new DataColumn("Addition_Cost"), new DataColumn("Addition_Cost_Reason"), new DataColumn("Total_Cost"), new DataColumn("Year_Week_No")
                                                        ,new DataColumn("Remark1"), new DataColumn("Remark2"), new DataColumn("Fuel_Rate") ,new DataColumn("Trans_Type")
                                                     });*/

                string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + path + " ; Extended Properties='Excel 8.0;IMEX=1;HDR=Yes;TypeGuessRows=0;ImportMixedTypes=Text;'";
                string connectionStringXLSX = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source= " + path + " ; Extended Properties=\"Excel 12.0;IMEX=1;HDR=Yes;TypeGuessRows=0;ImportMixedTypes=Text\"";

                connectionString = (path.ToLower().IndexOf("xlsx") > 0) ? connectionStringXLSX : connectionString;

                OleDbConnection conn = new OleDbConnection(connectionString);
                if (conn.State == ConnectionState.Open) conn.Close();
                conn.Open();

                try
                {
                    GetHaulierData(true);
                    DataTable dtHaulier = (DataTable)ViewState["HaulierUpload"];

                    string strSheet = "Normal";
                    string fileName = path.Split('\\').Length > 0 ? path.Split('\\')[path.Split('\\').Length - 1] : "";
                    


                    #region Insert

                    for (int i = 0; i < 2; i++)
                    {
                        int index = 0;
                        try {
                            
                            strSheet = (i == 0) ? "Normal" : "Dummy";
                            string sql = "select * from [" + strSheet + "$]";
                            OleDbCommand cmd = new OleDbCommand(sql, conn);
                            OleDbDataReader drRead = cmd.ExecuteReader();
                            DataView dv = null;
                            PHDS_HaulierUpload.TransportationRow dr = null;


                            while (drRead.Read())
                            {
                                if (!string.IsNullOrEmpty(drRead[0].ToString().Trim()))

                                {
                                    #region Insert Row
                                    try
                                    {
                                        dr = dtHaulierUp.NewTransportationRow();

                                        string s = drRead[4].ToString().Trim() !=""? int.Parse(drRead[4].ToString()).ToString("00000"):"00000";//String.Format("{0:00000}", );
                                        
                                        dr.PO_No = drRead[1].ToString().Trim();
                                        dr.Haulier_Abbr = drRead[0].ToString().Trim();
                                        try
                                        {
                                            dr.Delivery_Date = DateTime.ParseExact(drRead[3].ToString().Trim().Split(' ')[0], "M/d/yyyy", null).ToString("dd/MM/yyyy"); //drRead[3].ToString().Trim().Split(' ')[0];//
                                        }
                                        catch {
                                            dr.Delivery_Date = DateTime.ParseExact(drRead[3].ToString().Trim().Split(' ')[0], "d/M/yyyy", null).ToString("dd/MM/yyyy"); //drRead[3].ToString().Trim().Split(' ')[0];//
                                        }
                                        dr.Delivery_Ref = drRead[2].ToString().Trim();
                                        dr.Vendor_Code = s;
                                        dr.Vendor_Name = drRead[5].ToString().Trim();
                                        dr.Collection_Point = drRead[6].ToString().Trim();
                                        dr.Delivery_Location = drRead[7].ToString().Trim();
                                        dr.DC_No = 0;
                                        dr.RateType = drRead[8].ToString().Trim();
                                        dr.No_Of_Qty = drRead[9].ToString().Trim() == "" ? 0 : int.Parse(drRead[9].ToString().Trim());
                                        dr.Rate_Per_Unit = drRead[10].ToString().Trim() == "" ? 0 : decimal.Parse(drRead[10].ToString().Trim());
                                        dr.Currency = drRead[11].ToString().Trim();
                                        dr.Additional_Cost_Reason = drRead[13].ToString();//.Trim() == "" ? 0 : decimal.Parse(drRead[13].ToString().Trim());
                                        dr.Additional_Cost = drRead[12].ToString().Trim() == "" ? 0 : decimal.Parse(drRead[12].ToString().Trim());
                                        dr.Total_Cost = drRead[14].ToString().Trim() == "" ? 0 : decimal.Parse(drRead[14].ToString().Trim());
                                        dr.Year_Week_OnFile = drRead[15].ToString();
                                        dr.Year_Week_Upload = lblWeek.Text;
                                        dr.Remark1 = drRead[16].ToString().Trim();
                                        dr.Remark2 = drRead[17].ToString().Trim();
                                        dr.Fuel_Rate = drRead[18].ToString().Trim() == "" ? 0 : decimal.Parse(drRead[18].ToString().Trim());
                                        dr.FileName = fileName;
                                        dr.Trans_Type = IsErrCaseII(dr); // case II , III ,IV
                                                                         /*  =================================   */
                                        dr.Calc_Date = DateTime.Now;
                                        dr.RC_RateCardID = 0;
                                        dr.RC_Sell_Rate = 0;
                                        dr.Sell_Fuel_Rate = 0;
                                        dr.Total_Cost_Charging = 0;
                                        dr.StampTime = DateTime.Now;
                                        dr.UserID = int.Parse(Request["id"]);//PH_EncrptHelper.MD5Decryp();

                                        /*dt.Rows.Add(drRead[0], drRead[1], drRead[2], drRead[3]
                                                    , drRead[4], drRead[5], drRead[6], drRead[7]
                                                    , drRead[8], drRead[9], drRead[10], drRead[11]
                                                    , drRead[12], drRead[13], drRead[14], drRead[15]
                                                    , drRead[16], drRead[17], drRead[18],"");

                                        dt.Rows[dt.Rows.Count - 1][19] =  // case II , III ,IV*/

                                        if (IsErrCaseI(dr, dtHaulier.DefaultView))
                                        {
                                            isErr = true;
                                            dr.Remark1 = "dup";
                                        }
                                        else if (IsErrYearWeek(dr))
                                        {
                                            isErr = true;
                                            dr.Remark1 = "errYearWeek";
                                        }else if(checkHalier(dr) != "")
                                        {
                                            isErr = true;
                                            dr.Remark1 = "MissRateCard";
                                        }

                                    }
                                    catch (Exception ex)
                                    {
                                        dr.Remark1 = "err";
                                        dr.Remark2 = ex.Message;
                                    }

                                    dtHaulierUp.Rows.Add(dr);
                                    #endregion
                                }

                                index++;
                            }
                        }
                        catch(Exception ex) { PH_ExceptionManager.WriteError("Verlify Data >>" + " Row Index : " + index.ToString() + " err message : " + ex.Message); }
                    }

                    gvData.DataSource = dtHaulierUp;
                    gvData.DataBind();
                    ViewState["HaulierUploadInsert"] = dtHaulierUp;

                    if (isErr) btnInsert.Enabled = false;
                    else btnInsert.Enabled = true;


                    btnClear.Enabled = true;
                    #endregion


                }
                catch (Exception ex)
                {
                    lblErr.Text = ex.Message;
                    PH_ExceptionManager.WriteError("Verlify Data >>" + ex.Message);
                }
                finally
                {
                    if (!isErr) lblErr.Text = "";
                }

            }
            catch (Exception ex)
            {
                throw new Exception("InsertData>>" + ex.Message);
            }
        }

        private bool IsErrYearWeek(PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                if (dr.Year_Week_OnFile != lblWeek.Text) return true;
                else return false;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private bool IsErrCaseI(PHDS_HaulierUpload.TransportationRow dr, DataView dv)
        {
            try
            {
                string str = "Haulier_Abbr='" + dr.Haulier_Abbr + "' and PO_no='" + dr.PO_No + "' and Delivery_ref='" + dr.Delivery_Ref + "' and Delivery_date='" + dr.Delivery_Date + "' ";
                str += "and Vendor_code = '" + dr.Vendor_Code  + "' and Delivery_location = '" + dr.Delivery_Location + "'";
                str += "and Ratetype = '" + dr.RateType + "' and Rate_Per_Unit = '" + dr.Rate_Per_Unit + "'"; // + "' and Collection_point = '" + dr.Collection_Point
                dv.RowFilter = new System.Text.StringBuilder().Append(str).ToString();

                return dv.Count > 0 ? true : false;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private string IsErrCaseII(PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                string str = "";
                if (string.IsNullOrEmpty(dr.PO_No) && dr.Remark1.Trim().ToLower() == "miscellaneous") str = "M";
                else if (string.IsNullOrEmpty(dr.PO_No) && dr.Remark1.Trim().ToLower() == "rejecteditems") str = "R";
                else if (string.IsNullOrEmpty(dr.PO_No)) str = "N";
                else if (dr.Vendor_Name == "Dummy" && dr.PO_No == "" && dr.Total_Cost >0) str = "L";
                

                return str;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private string checkHalier(PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                string rtn = PH_HaulierUpload.PH_HaulierUp_FindRateCard(AppCode.strConnDB, dr);

                return rtn;
            }
            catch(Exception ex)
            {
                throw new Exception("checkHalier >> " + ex.Message);
            }
        }


        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try {
                bool isError = false;
                string strMess = "";
                PHDS_HaulierUpload.TransportationDataTable dt = (PHDS_HaulierUpload.TransportationDataTable)ViewState["HaulierUploadInsert"];
                foreach (PHDS_HaulierUpload.TransportationRow dr in dt.Rows)
                {
                    try {
                        PH_HaulierUpload.PH_HaulierUp_Insert(AppCode.strConnDB, dr);
                        PH_HaulierUpload.PH_HaulierUpLog_Insert(AppCode.strConnDB, int.Parse(Request["id"]), lblWeek.Text, Session["fileName"].ToString(),dr.Haulier_Abbr.ToString());
                    }
                    catch(Exception ex)
                    {
                        isError = true;
                        strMess = ex.Message;
                        PH_ExceptionManager.WriteError("btnInsert_Click ,PH_HaulierUp_Insert >>" + ex.Message);
                    }

                }

                /*if( !isError )
                {
                    try {
                        // no error insert logs
                        PH_HaulierUpload.PH_HaulierUpLog_Insert(AppCode.strConnDB, int.Parse(Request["id"]), lblWeek.Text, Session["fileName"].ToString());
                    }
                    catch(Exception ex)
                    {
                        isError = true;
                        strMess = ex.Message;
                        PH_ExceptionManager.WriteError("btnInsert_Click ,PH_HaulierUpLog_Insert >>" + ex.Message);
                    }
                }*/


                string message = !isError ? "Save Data Successfull" : "Save Data Not Successfull";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('" + message + "');", true);
                btnInsert.Enabled = false;
                btnSubmit.Enabled = false;
                btnClear.Enabled = false;
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError("btnInsert_Click >>" + ex.Message);
            }
        }

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string strPoNo = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "po_no"));
                e.Row.Cells[1].Text = strPoNo.Replace(",", " ,");

                string Status = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Remark1"));

                if (Status == "err" || Status == "dup" || Status == "errYearWeek" || Status == "MissRateCard")
                {
                    e.Row.Attributes["style"] = "background-color: #FF9999";
                }
                else
                {
                    e.Row.Cells[11].Text = "";
                }
            }
        }

        private void ClearView()
        {
            ViewState["HaulierUpload"] = null;
            gvData.DataSource = null;
            gvData.DataBind();
        }


        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearView();
        }
    }
}
