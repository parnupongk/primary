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
    public partial class rate_calc_adj : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBindDDl();
                if (Request["r"] == "A2") btnCalc.Visible = false;
            }

        }

        private void DataBindDDl()
        {
            try
            {
                DataSet ds = PH_RateCalc.PH_RateCalc_DateWeekSelAll(AppCode.strConnDB);
                ddlDateWeek.DataTextField = "dateweek";
                ddlDateWeek.DataValueField = "dateweek";
                ddlDateWeek.DataSource = ds;
                ddlDateWeek.DataBind();

                /*DataTable dt = PH_UserVendor.PH_UserVendor_SelectAll(AppCode.strConnDB);
                ddlVendorCode.DataTextField = "vendor_code";
                ddlVendorCode.DataValueField = "vendor_code";
                ddlVendorCode.DataSource = dt;
                ddlVendorCode.DataBind();*/

                DataTable dt = PH_HaulierInfo.PH_Haulier_SelAll(AppCode.strConnDB);
                ddlHaluier.DataTextField = "haulier_abbr";
                ddlHaluier.DataValueField = "haulier_abbr";
                ddlHaluier.DataSource = dt;
                ddlHaluier.DataBind();
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }

}
        private void DataBindTrans(bool isNew)
        {
            try
            {
                DataSet ds;
                if (isNew)
                {

                    ds = PH_RateCalc.PH_RateCalcAdj_TransportSel(AppCode.strConnDB, ddlHaluier.SelectedValue, txtVendorCode.Text, ddlDateWeek.SelectedValue);
                }
                else
                {
                    ds =(DataSet) ViewState["RateCalcAdj"];
                }

                ViewState["RateCalcAdj"] = ds;
                gvData.DataSource = ds;
                gvData.DataBind();
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DataBindTrans(true);
        }

        protected void gvData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //string str = e.CommandName;
            //str = str;

        }

        protected void gvData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try {
                TextBox txtOldnoQty = (TextBox)gvData.Rows[e.RowIndex].FindControl("txtOldNoQty");
                TextBox txtNewnoQty = (TextBox)gvData.Rows[e.RowIndex].FindControl("txtNewNoQty");
                int rtn = 0;
                if (txtNewnoQty.Text != "" && txtOldnoQty.Text != "")
                {
                    //int.Parse(Request["id"])
                    rtn = PH_RateCalc.PH_RateCaclAdj_TransportInsert(AppCode.strConnDB, gvData.DataKeys[e.RowIndex].Value.ToString(), int.Parse(Request["id"]), int.Parse(txtOldnoQty.Text));
                    if (rtn > 0) rtn = PH_RateCalc.PH_RateCaclAdj_TransportInsert(AppCode.strConnDB, gvData.DataKeys[e.RowIndex].Value.ToString(), int.Parse(Request["id"]), int.Parse(txtNewnoQty.Text));
                }

                string message = rtn > 0 ? "Save Data Successfull" : "Save Data Not Successfull";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('" + message + "');", true);

                gvData.EditIndex = -1;
                DataBindTrans(true);
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void gvData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvData.EditIndex = e.NewEditIndex;
            DataBindTrans(false);
        }

        protected void gvData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvData.EditIndex = -1;
            DataBindTrans(false);
        }

        protected void btnCalc_Click(object sender, EventArgs e)
        {
            try
            {
                int rtn = PH_RateCalc.PH_RateCaclAdj_TransportUpdate(AppCode.strConnDB, ddlHaluier.SelectedValue, ddlDateWeek.SelectedValue,txtVendorCode.Text);

                string message = rtn > 0 ? "Calculate Completed" : "Calculate  Not Completed";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alert('" + message + "');", true);
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string deliveryRef = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Delivery_Ref"));
                string strPoNo = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "po_no"));
                e.Row.Cells[1].Text = strPoNo.Replace(",", " ,");

                if( Request["r"] == "A2" || deliveryRef.Trim().ToUpper() == "ADJ")
                {
                    LinkButton lbkBtn = (LinkButton)e.Row.Cells[10].Controls[0]; //here use the cell no in which your edit command button is there.
                    lbkBtn.Visible = false;//write a logic to disable or enable according to privilages.
                }
            }
        }
    }
}