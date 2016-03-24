using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul_WS.AppCode_DS;


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
            gvData.DataSource = null;
            gvData.DataBind();
        }

        private void InsertData(string path)
        {
            bool isErr = false;

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
                    int strUserId = int.Parse(Request["id"]);
                    string strSheet = "Normal";
                    string fileName = path.Split('\\').Length > 0 ? path.Split('\\')[path.Split('\\').Length - 1] : "";
                    //DataTable dtSheet = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);


                    #region Insert
                    //for (int index = 0; index < 2; index++)
                    //foreach (DataRow drSheet in dtSheet.Rows)
                    //{
                    int index = 0;
                    try
                    {

                        strSheet = "bh_transaction";

                        string sql = "select * from [" + strSheet + "$]";
                        OleDbCommand cmd = new OleDbCommand(sql, conn);
                        OleDbDataReader drRead = cmd.ExecuteReader();
                        PHDS_BHUpload.BH_Transaction_TMPRow dr = null;
                        int rowCount = 0, rowError = 0, rowSucc = 0;
            
                        while (drRead.Read())
                        {
                            if (!string.IsNullOrEmpty(drRead[0].ToString().Trim()))
                            {
                                #region Insert Row
                                try
                                {
                                    dr = dtBHTrans.NewBH_Transaction_TMPRow();
                                    dr.Week = drRead[0].ToString();
                                    dr.Period = string.IsNullOrEmpty(drRead[1].ToString()) ?0: int.Parse(drRead[1].ToString());
                                    dr.Vendor_Name = drRead[2].ToString();
                                    try
                                    {
                                        dr.Appt_Date = DateTime.ParseExact(drRead[3].ToString().Trim().Split(' ')[0], "M/d/yyyy", null); //drRead[3].ToString().Trim().Split(' ')[0];//
                                    }
                                    catch
                                    {
                                        dr.Appt_Date = DateTime.ParseExact(drRead[3].ToString().Trim().Split(' ')[0], "d/M/yyyy", null); //drRead[3].ToString().Trim().Split(' ')[0];//
                                    }
                                    dr.Load_Appt = string.IsNullOrEmpty(drRead[4].ToString()) ? 0 : int.Parse(drRead[4].ToString());
                                    dr.Load_Rcvd = string.IsNullOrEmpty(drRead[5].ToString()) ? 0 : int.Parse(drRead[5].ToString());
                                    dr.PO_No = drRead[6].ToString();
                                    dr.DC_No = string.IsNullOrEmpty(drRead[7].ToString()) ? 0 : int.Parse(drRead[7].ToString());
                                    dr.Load_No = string.IsNullOrEmpty(drRead[8].ToString()) ? 0 : int.Parse(drRead[8].ToString());
                                    dr.Appt_To_DC = drRead[9].ToString();
                                    dr.Type = string.IsNullOrEmpty(drRead[10].ToString()) ? 0 : int.Parse(drRead[10].ToString());
                                    dr.Appt_No = drRead[11].ToString();
                                    dr.Case_Appt = string.IsNullOrEmpty(drRead[12].ToString()) ? 0 : int.Parse(drRead[12].ToString());
                                    dr.Pallet =string.IsNullOrEmpty(drRead[13].ToString()) ? 0 : int.Parse(drRead[13].ToString());
                                    dr.Remark = drRead[14].ToString();
                                    dr.Pallet_From_Vendor = string.IsNullOrEmpty(drRead[15].ToString()) ? 0 : int.Parse(drRead[15].ToString());
                                    dr.Total_Pallet_From_Vendor = string.IsNullOrEmpty(drRead[16].ToString()) ? 0 : int.Parse(drRead[16].ToString());
                                    dr.Rate = string.IsNullOrEmpty(drRead[17].ToString()) ? 0 : decimal.Parse(drRead[17].ToString());
                                    dr.Rate_Unloading = string.IsNullOrEmpty(drRead[18].ToString()) ? 0 : int.Parse(drRead[18].ToString());
                                    dr.File_Name = fileName;
                                    dr.UserID = strUserId;
                                    dr.StampTime = DateTime.Now;
                                    dr.Week_Upload = lblWeek.Text;
                                    dr.Week_OnFile = lblWeek.Text;

                                }
                                catch (Exception ex)
                                {
                                    rowError++;
                                    dr.Status = "err";
                                    //dr.Remark2 = ex.Message;
                                    PH_ExceptionManager.WriteError("prepare data BHUpload >> err message : " + ex.Message);
                                }

                                dtBHTrans.Rows.Add(dr);
                                PH_BHUpload.PH_BHTransaction_InsertTMP(AppCode.strConnDB, dr);
                                #endregion
                            }

                        }
                    }
                    catch (Exception ex) { lblErr.Text += ex.Message; ; PH_ExceptionManager.WriteError("Verlify Data >>" + " Row Index : " + index.ToString() + " err message : " + ex.Message); }
                    //}

                    DataBind_BHTrans(strUserId.ToString());
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

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "status"));
                if (Status.IndexOf("err") >-1)
                {
                    e.Row.Attributes["style"] = "background-color: #FF9999";
                    btnInsert.Enabled = false;
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
    }
}