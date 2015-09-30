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
            }
        }

        private void DataBindDateWeek()
        {
            try {
                DataSet ds = PH_RateCalc.PH_RateCalc_DateWeekSelAll(AppCode.strConnDB);

                ddlDateWeek.DataSource = ds;
                ddlDateWeek.DataValueField = "dateweek";
                ddlDateWeek.DataTextField = "dateweek";
                if (ddlDateWeek.Items.Count > 0)
                {
                    ddlDateWeek.ClearSelection();
                    ddlDateWeek.Items[ddlDateWeek.Items.Count - 1].Selected = true;
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
                DataSet ds = PH_RateCalc.PH_ReateCalc_HaulierSelByDateWeek(AppCode.strConnDB, ddlDateWeek.SelectedItem.Text);
                ViewState["DataRateCalc"] = ds;
                gvData.DataSource = ds;
                gvData.DataBind();
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBindHaulier >>" + ex.Message);
            }
        }

        protected void ddlDateWeek_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataBindHaulier();
        }

        protected void btnAddSubmit_Click(object sender, EventArgs e)
        {
            DataSet ds = (DataSet)ViewState["DataRateCalc"];
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                int iSucc = 0, iErr = 0, iRtn = 0;
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    iRtn = PH_RateCalc.PH_RateCalc_TransporationCalc(AppCode.strConnDB, dr);
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

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }
    }
}