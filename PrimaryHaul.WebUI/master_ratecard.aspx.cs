using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class master_ratecard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           if(!IsPostBack)
            {
                DataBindData(true);
                DataBindColl();
                DataBindDC();
                DataBindRateType();
            }
        }

        private void DataBindData(bool isNew)
        {
            DataTable dt = null;
            if (!isNew && ViewState["RateCardInfo"] !=null)
            {
                dt = (DataTable)ViewState["RateCardInfo"];
                
            }
            else
            {
                dt = PH_RateCardInfo.PH_RateCard_SelAll(AppCode.strConnDB);
            }

            ViewState["RateCardInfo"] = dt;
            gvData.DataSource = dt;
            gvData.DataBind();
        }
        private void DataBindColl()
        {
            DataTable dt = PH_RateCardInfo.PH_Collection_SelAll(AppCode.strConnDB);
            ddlCollectionPoint.DataTextField = "collection_point";
            ddlCollectionPoint.DataValueField = "coll_id";
            ddlCollectionPoint.DataSource = dt;
            ddlCollectionPoint.DataBind();
            
        }
        private void DataBindDC()
        {
            DataTable dt = PH_RateCardInfo.PH_DC_SelAll(AppCode.strConnDB);
            ddlDC.DataTextField = "dc_name";
            ddlDC.DataValueField = "dc_abbr";
            ddlDC.DataSource = dt;
            ddlDC.DataBind();

        }
        private void DataBindRateType()
        {
            DataTable dt = PH_RateCardInfo.PH_RateType_SelAll(AppCode.strConnDB);
            ddlRateType.DataTextField = "ratetype";
            ddlRateType.DataValueField = "ratetype_id";
            ddlRateType.DataSource = dt;
            ddlRateType.DataBind();

        }


        protected void AjaxFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            string fileName = DateTime.Now.ToString("yyyMMddHHss") + new Random().Next(999) + e.ContentType;// +e.FileName;
            string fullPath = Server.MapPath(ConfigurationManager.AppSettings["PH_FolderUpload"] + fileName);
            AjaxFileUpload.SaveAs(fullPath);
            Session["fileName"] = fullPath;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if( Session["fileName"] != null )
            {
                if (InsertData(Session["fileName"].ToString())) ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('Import Data Successful');", true);
                else ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", "alertMessage('Import Data Not Successful');", true);
            }
        }

        private bool InsertData(string path)
        {
            DataTable dt = new DataTable();
            DataTable dtColl = new DataTable();
            DataTable dtRate = new DataTable();
            dtRate.Columns.AddRange(new DataColumn[] { new DataColumn("RateType"), new DataColumn("StampTime") });
            dtColl.Columns.AddRange(new DataColumn[] { new DataColumn("Collection_Point"), new DataColumn("StampTime") });
            dt.Columns.AddRange(new DataColumn[] { new DataColumn("Vendor_Code"), new DataColumn("Vendor_Name"), new DataColumn("StartDate"), new DataColumn("EndDate")
                                                        ,new DataColumn("Collection_Point"), new DataColumn("DC_ABBR"), new DataColumn("Transporter_Name"), new DataColumn("Buy_Rate")
                                                        ,new DataColumn("Buy_RateType"), new DataColumn("Buy_RateType_Info"), new DataColumn("Load_Type"), new DataColumn("Transporter_Desc")
                                                        ,new DataColumn("Sell_Rate"), new DataColumn("Sell_RateType"), new DataColumn("Currency"), new DataColumn("Fuel_Rate_From")
                                                        ,new DataColumn("Fuel_Rate_To")
                                                     });
            //Response.Write(path);
            string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source= " + path + " ; Extended Properties=Excel 8.0;";
            OleDbConnection conn = new OleDbConnection(connectionString);
            if (conn.State == ConnectionState.Open) conn.Close();
            conn.Open();

            try
            {
                #region Insert
                string strTempRate = "", strTempColl = "";
                string sql = "select * from [Sheet1$]";
                OleDbCommand cmd = new OleDbCommand(sql, conn);
                OleDbDataReader drRead = cmd.ExecuteReader();

                while (drRead.Read())
                {
                    if (drRead[0].ToString() != "" && drRead[1].ToString() != "")
                    {

                        if (strTempColl != drRead[4].ToString()) PH_RateCardInfo.PH_CollectionPoint_Insert(AppCode.strConnDB, drRead[4].ToString());  //dtColl.Rows.Add(drRead[4], DateTime.Now);
                        if (strTempRate != drRead[8].ToString()) PH_RateCardInfo.PH_RateType_Insert(AppCode.strConnDB, drRead[8].ToString());//dtRate.Rows.Add(drRead[8], DateTime.Now);
                        dt.Rows.Add(drRead[0], drRead[1], drRead[2], drRead[3]
                            , drRead[4], drRead[5], drRead[6], drRead[7]
                            , drRead[8], drRead[9], drRead[10], drRead[11]
                            , drRead[12], drRead[13], drRead[14], drRead[15]
                            , drRead[16]);

                        PH_RateCardInfo.PH_RateCard_Insert(AppCode.strConnDB, dt.Rows[dt.Rows.Count - 1]);

                        strTempRate = drRead[8].ToString();
                        strTempColl = drRead[4].ToString();
                    }

                }


                gvData.DataSource = dt;
                gvData.DataBind();


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

        protected void gvData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvData.EditIndex = e.NewEditIndex;
            
            DataBindData(false);
        }

        protected void gvData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvData.EditIndex = -1;
            DataBindData(false);
        }

        protected void gvData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            TextBox txtEndDate = (TextBox)gvData.Rows[e.RowIndex].FindControl("txtEndDate");
            if(txtEndDate.Text != "")
            {
                string message = PH_RateCardInfo.PH_RateCard_Update(AppCode.strConnDB, gvData.DataKeys[e.RowIndex].Value.ToString(), DateTime.ParseExact(txtEndDate.Text, "MM/dd/yyyy", null)) > 0 ? "Save Data Successfull" : "Save Data Not Successfull";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('"+ message + "');", true);

                gvData.EditIndex = -1;
                DataBindData(true);
            }
        }

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowType == DataControlRowType.DataRow) && (e.Row.RowState.HasFlag(DataControlRowState.Edit) && (e.Row.DataItem != null)))
            {
                TextBox txtEndDate = (TextBox)e.Row.FindControl("txtEndDate");
                txtEndDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            }
        }
        private void claredata()
        {
            txtVendorCode.Text = "";
            txtVendorName.Text = "";
            txtBuyRate.Text = "";
            txtSellRate.Text = "";
            txtRateFrom.Text = "";
            txtRateTo.Text = "";
        }
        protected void btnAddSubmit_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[] { new DataColumn("Vendor_Code"), new DataColumn("Vendor_Name"), new DataColumn("StartDate"), new DataColumn("EndDate")
                                                        ,new DataColumn("Collection_Point"), new DataColumn("DC_ABBR"), new DataColumn("Transporter_Name"), new DataColumn("Buy_Rate")
                                                        ,new DataColumn("Buy_RateType"), new DataColumn("Buy_RateType_Info"), new DataColumn("Load_Type"), new DataColumn("Transporter_Desc")
                                                        ,new DataColumn("Sell_Rate"), new DataColumn("Sell_RateType"), new DataColumn("Currency"), new DataColumn("Fuel_Rate_From")
                                                        ,new DataColumn("Fuel_Rate_To")
                                                     });
            dt.Rows.Add(txtVendorCode.Text, txtVendorName.Text, DateTime.Now.ToString("MM/dd/yyyy"), null
                        , ddlCollectionPoint.SelectedItem, ddlDC.SelectedValue, "NSL", txtBuyRate.Text
                        , ddlRateType.SelectedItem, ddlRateType.SelectedItem, "", ""
                        , txtSellRate.Text, ddlRateType.SelectedItem, "THB", txtRateFrom.Text
                        , txtRateTo.Text);

            string message = PH_RateCardInfo.PH_RateCard_Insert(AppCode.strConnDB, dt.Rows[dt.Rows.Count - 1]) > 0 ? "Save Data Successfull" : "Save Data Not Successfull";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('" + message + "');", true);
            DataBindData(true);
        }
    }
}