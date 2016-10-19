using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Text.RegularExpressions;
using PrimaryHaul_WS;
using PrimaryHaul_WS.AppCode_DS;
using PPH_SC;


namespace PrimaryHaul.WebUI
{
    public partial class bh_transaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnClear.Enabled = false;
                btnSubmit.Enabled = false;
                btnInsert.Enabled = false;
                lblWeek.Text = PH_HaulierUpload.PH_HaulierUp_GetDateWeek(AppCode.strConnDB);
            }
        }

        protected void AjaxFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            try
            {
                string fileName = "bh_" + DateTime.Now.ToString("yyyMMddHHss") + new Random().Next(999) + e.ContentType;// +e.FileName;
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
                lblErr.Text = "";
                InsertData(Session["fileName"].ToString());
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError("verlify data >>" + ex.Message);
            }
        }



        private void ClearView()
        {
            lblErr.Text = "";
            gvData.DataSource = null;
            gvData.DataBind();
        }

        private void InsertData(string path)
        {

            try
            {

                PHDS_BHUpload.BH_Transaction_TMPDataTable dtBHTrans = new PHDS_BHUpload.BH_Transaction_TMPDataTable();
                string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + path + " ; Extended Properties='Excel 8.0;IMEX=1;HDR=Yes;TypeGuessRows=0;ImportMixedTypes=Text;'";
                string connectionStringXLSX = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source= " + path + " ; Extended Properties=\"Excel 12.0;IMEX=1;HDR=Yes;TypeGuessRows=0;ImportMixedTypes=Text\"";

                connectionString = (path.ToLower().IndexOf("xlsx") > 0) ? connectionStringXLSX : connectionString;

                OleDbConnection conn = new OleDbConnection(connectionString);
                if (conn.State == ConnectionState.Open) conn.Close();
                conn.Open();

                try
                {
                    lblErr.Text = "";
                    bool isSheetName = false;
                    int strUserId = int.Parse(Request["id"]);
                    string strSheet = "data wk" + lblWeek.Text.Substring(4,2);
                    string fileName = path.Split('\\').Length > 0 ? path.Split('\\')[path.Split('\\').Length - 1] : "";
                    DataTable dtSheet = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                    foreach (DataRow drSheet in dtSheet.Rows)
                    {
                        if (drSheet["TABLE_NAME"].ToString().Replace("'", "").Replace("$", "").ToLower() == strSheet.ToLower()) isSheetName = true;
                    }
                    if (isSheetName)
                    {

                        #region Insert
                        //for (int index = 0; index < 2; index++)
                        //foreach (DataRow drSheet in dtSheet.Rows)
                        //{
                        int index = 0;
                        int rowCount = 0, rowError = 0, rowSucc = 0;
                        try
                        {

                            //strSheet = "bh_transaction";

                            string sql = "select * from [" + strSheet + "$]";
                            OleDbCommand cmd = new OleDbCommand(sql, conn);
                            OleDbDataReader drRead = cmd.ExecuteReader();
                            PHDS_BHUpload.BH_Transaction_TMPRow dr = null;

                            string strColumns = "";
                            while (drRead.Read())
                            {
                                if (!string.IsNullOrEmpty(drRead[0].ToString().Trim()))
                                {
                                    if (drRead[0].ToString().Trim().ToLower() != "week"){
                                    #region Insert Row
                                    try
                                    {
                                        index++;
                                        dr = dtBHTrans.NewBH_Transaction_TMPRow();
                                        dr.Week = drRead[0].ToString();
                                        dr.Vendor_Name = drRead[2].ToString();
                                        try
                                        {
                                            dr.Appt_Date = DateTime.ParseExact(drRead[3].ToString().Trim().Split(' ')[0], "M/d/yyyy", null); //drRead[3].ToString().Trim().Split(' ')[0];//
                                        }
                                        catch
                                        {
                                            dr.Appt_Date = DateTime.ParseExact(drRead[3].ToString().Trim().Split(' ')[0], "d/M/yyyy", null); //drRead[3].ToString().Trim().Split(' ')[0];//
                                        }

                                        dr.PO_No = drRead[6].ToString();
                                        dr.Appt_To_DC = drRead[9].ToString();
                                        dr.Appt_No = drRead[11].ToString();
                                        dr.Remark = drRead[14].ToString();
                                        dr.File_Name = fileName;
                                        dr.UserID = strUserId;
                                        dr.StampTime = DateTime.Now;
                                        dr.Week_Upload = lblWeek.Text;
                                        dr.Week_OnFile = lblWeek.Text;

                                        dr.Period = !Regex.IsMatch(drRead[4].ToString(), @"\d") ? 0 : int.Parse(drRead[1].ToString());
                                        strColumns = "Period";
                                        dr.Load_Appt = !Regex.IsMatch(drRead[4].ToString(), @"\d") ? 0 : int.Parse(drRead[4].ToString());
                                        strColumns = "Load_Appt";
                                        dr.Load_Rcvd = !Regex.IsMatch(drRead[5].ToString(), @"\d") ? 0 : int.Parse(drRead[5].ToString());
                                        strColumns = "Load_Rcvd";
                                        dr.DC_No = !Regex.IsMatch(drRead[7].ToString(), @"\d") ? 0 : int.Parse(drRead[7].ToString());
                                        strColumns = "DC_No";
                                        dr.Load_No = !Regex.IsMatch(drRead[8].ToString(), @"\d") ? 0 : int.Parse(drRead[8].ToString());
                                        strColumns = "Load_No";
                                        dr.Type = !Regex.IsMatch(drRead[10].ToString(), @"\d") ? 0 : int.Parse(drRead[10].ToString());
                                        strColumns = "Type";
                                        dr.Case_Appt = !Regex.IsMatch(drRead[12].ToString(), @"\d") ? 0 : Convert.ToInt32(decimal.Parse(drRead[12].ToString()));
                                        strColumns = "Case_Appt";
                                            //dr.Pallet = !Regex.IsMatch(drRead[13].ToString(), @"\d") ? 0 : decimal.Parse(drRead[13].ToString());
                                            dr.Pallet = drRead[13].ToString();
                                            strColumns = "Pallet";
                                        dr.Pallet_From_Vendor = !Regex.IsMatch(drRead[15].ToString(), @"\d") ? 0 : decimal.Parse(drRead[15].ToString());
                                        strColumns = "Pallet_From_Vendor";
                                        dr.Total_Pallet_From_Vendor = !Regex.IsMatch(drRead[16].ToString(), @"\d") ? 0 : int.Parse(drRead[16].ToString());
                                        strColumns = "Total_Pallet_From_Vendor";
                                        dr.Rate = !Regex.IsMatch(drRead[17].ToString(), @"\d") ? 0 : decimal.Parse(drRead[17].ToString());
                                        strColumns = "Rate";
                                        dr.Rate_Unloading = !Regex.IsMatch(drRead[18].ToString(), @"\d") ? 0 : int.Parse(drRead[18].ToString());
                                        strColumns = "Rate_Unloading";
                                            dr.Fuel_Rate = !Regex.IsMatch(drRead[20].ToString(), @"\d") ? 0 : decimal.Parse(drRead[20].ToString());

                                            dtBHTrans.Rows.Add(dr);
                                        //PH_BHUpload.PH_BHTransaction_InsertTMP(AppCode.strConnDB, dr);
                                        if (PPH_BH.insert_bhtransactonTMP(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], dr.Week_Upload, dr.Week, dr.Period, dr.Vendor_Name, dr.Appt_Date, dr.Load_Appt, dr.Load_Rcvd, dr.PO_No, dr.DC_No, dr.Load_No, dr.Appt_To_DC, dr.Type, dr.Appt_No, dr.Case_Appt, dr.Pallet, dr.Remark, dr.Pallet_From_Vendor, dr.Total_Pallet_From_Vendor, dr.Rate, dr.Rate_Unloading, dr.File_Name, dr.UserID,dr.Fuel_Rate) == true)
                                        {
                                           
                                        }
                                        rowSucc++;
                                    }
                                    catch (Exception ex)
                                    {
                                        rowError++;
                                        dr.Status = "err";
                                        //dr.Remark2 = ex.Message;
                                        PH_ExceptionManager.WriteError("prepare data BHUpload >> row index : " + index.ToString() + " Columns Err : " + strColumns + "err message : " + ex.Message);
                                    }

                                    }
                                    #endregion
                                }

                            }
                        }
                        catch (Exception ex) { lblErr.Text += ex.Message; ; PH_ExceptionManager.WriteError("Verlify Data >>" + " Row Index : " + index.ToString() + " err message : " + ex.Message); }
                        //}

                        DataBind_BHTrans(strUserId.ToString());
                        //if (rowError == 0)
                        //{
                            btnInsert.Enabled = true;
                        //}
                        btnClear.Enabled = true;
                        lblErr.Text = " Success=" + rowSucc.ToString() + " Error=" + rowError.ToString();
                        #endregion

                    }
                    else
                    {
                        lblErr.Text = "Sheet name incorrect";
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = ex.Message;
                    PH_ExceptionManager.WriteError("Verlify Data >>" + ex.Message);
                }
                finally
                {
                    // lblErr.Text = "";
                }

            }
            catch (Exception ex)
            {
                throw new Exception("InsertData>>" + ex.Message);
            }
        }

        private void DataBind_BHTrans(string strUserId)
        {
            try
            {


                DataTable dt = PH_BHUpload.PH_BHTransaction_SelTMP(AppCode.strConnDB, lblWeek.Text, strUserId);
                ViewState["BH_TRANSACTION"] = dt;
                gvData.DataSource = dt;
                gvData.DataBind();
                    
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBind_BHTrans >>" + ex.Message);
            }
        }

        private void DataBindPageIndex_BHTrans()
        {
            try
            {


               
                DataTable dt = (DataTable)ViewState["BH_TRANSACTION"];
                gvData.DataSource = dt;
                gvData.DataBind();

            }
            catch (Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBind_BHTrans >>" + ex.Message);
            }
        }

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "status"));
                if (Status.IndexOf("err") >-1)
                {
                    e.Row.Attributes["style"] = "background-color: #FF9999";
                    //btnInsert.Enabled = false;
                }
                /*else
                {
                    e.Row.Cells[11].Text = "";
                }*/
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearView();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            int rtn = PH_BHUpload.PH_BHTransaction_Insert(AppCode.strConnDB, lblWeek.Text, Request["id"]);

            string message = rtn >0? "Save Data Successfull" : "Save Data Not Successfull";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('" + message + "');", true);
            btnInsert.Enabled = false;
            btnSubmit.Enabled = false;
            btnClear.Enabled = false;
            ClearView();
        }

        protected void gvData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvData.PageIndex = e.NewPageIndex;
            DataBindPageIndex_BHTrans();
        }
    }
}