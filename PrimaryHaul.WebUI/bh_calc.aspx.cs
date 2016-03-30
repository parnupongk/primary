using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class bh_calc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBindDateWeek();
                DataBindTransCalc();
                //if (Request["r"] == "A2") btnAddSubmit.Visible = false;
            }
        }

        private void DataBindTransCalc()
        {
            try
            {
                if (string.IsNullOrEmpty(ddlDateWeek.SelectedValue))
                {
                    DataTable dt = PH_BHCalc.PH_BHTransCacl_Sel(AppCode.strConnDB, ddlDateWeek.SelectedValue.ToString());
                    gvData.DataSource = dt;
                    gvData.DataBind();
                }
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBindTransCalc >>" + ex.Message);
            }
        }

        private void DataBindDateWeek()
        {
            try
            {
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
            catch (Exception ex)
            {
                PH_ExceptionManager.WriteError("DataBindDateWeek >>" + ex.Message);
            }
        }

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string strFileName = gvData.Rows[e.RowIndex].Cells[2].Text;
            PH_BHCalc.PH_BHTransCalc_Delete(AppCode.strConnDB, ddlDateWeek.SelectedValue, strFileName);
            DataBindTransCalc();
        }

        protected void gvData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if( e.CommandName == "Calc" )
            {

                PH_BHCalc.PH_BHTrans_Calc(AppCode.strConnDB, ddlDateWeek.SelectedValue);
                DataBindTransCalc();
            }
        }

        protected void ddlDateWeek_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataBindTransCalc();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DataBindTransCalc();
        }
    }
}