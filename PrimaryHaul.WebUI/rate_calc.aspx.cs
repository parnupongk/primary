using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class rate_calc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                DataBindDateWeek();
                DataBindHaulier();
                if (Request["r"] == "A2") btnAddSubmit.Visible = false;
            }
        }

        private void DataBindDateWeek()
        {
            try {
                DataSet ds = PH_RateCalc.PH_RateCalc_DateWeekSelAll(AppCode.strConnDB);
                //PH_ExceptionManager.WriteError("DataBindDateWeek >>" + ds.Tables[0].Rows.Count);
                ddlDateWeek.DataValueField = "dateweek";
                ddlDateWeek.DataTextField = "dateweek";
                ddlDateWeek.DataSource = ds.Tables[0];
                ddlDateWeek.DataBind();
                if (ddlDateWeek.Items.Count > 0)
                {
                    ddlDateWeek.ClearSelection();
                    ddlDateWeek.Items[0].Selected = true;
                }
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBindDateWeek >>" + ex.Message);
            }
        }

        private void DataBindHaulier()
        {
            try
            {
                DataSet dsHaulier = PH_RateCalc.PH_ReateCalc_HaulierSelByDateWeek(AppCode.strConnDB, ddlDateWeek.SelectedItem.Text);
                ViewState["DataRateCalc"] = dsHaulier;
                if (dsHaulier.Tables[0].Rows.Count > 0)
                {
                    gvData.Visible = true;

                    gvData.DataSource = dsHaulier;
                    gvData.DataBind();
                }
                else
                {
                    lblErr.Text = "data not found.";
                    gvData.Visible = false;
                }
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBindHaulier >>" + ex.Message);
            }
        }

        protected void ddlDateWeek_SelectedIndexChanged(object sender, EventArgs e)
        {
            try {
                lblErr.Text = "";
                DataBindHaulier();
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected void btnAddSubmit_Click(object sender, EventArgs e)
        {
            try {
                DataSet ds = (DataSet)ViewState["DataRateCalc"];
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    int iSucc = 0, iErr = 0, iRtn = 0;
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        iRtn = PH_RateCalc.PH_RateCalc_TransporationCalc(AppCode.strConnDB, dr,ddlDateWeek.SelectedItem.Text);
                        if (iRtn > 0) iSucc++;
                        else iErr++;
                    }

                    lblErr.Text = iSucc + "/" + ds.Tables[0].Rows.Count + "  Haulier , Calculate Completed";
                    DataBindHaulier();
                }
                else
                {
                    lblErr.Text = "No Data Calculate.";
                }
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError("btnAddSubmit_Click>> " + ex.Message);
                lblErr.Text = ex.Message;
            }
        }

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void gvData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string strAbbr = gvData.Rows[e.RowIndex].Cells[2].Text;
            PH_RateCalc.PH_RateCacl_TransportDelete(AppCode.strConnDB, strAbbr, ddlDateWeek.SelectedValue);

            DataBindHaulier();
        }
    }
}