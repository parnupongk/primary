using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using PrimaryHaul_WSFlow;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class changeprofile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                if (!IsPostBack)
                {
                    if (Request["id"] != null && Request["id"] != "")
                    {
                        DataTable dt = PHCore_User.SelByUserId(AppCode.strConnDB, Request["id"]);
                        if(dt.Rows.Count >0)
                        {
                            txtContact.Text = dt.Rows[0]["contact_person"].ToString();
                            txtMobile.Text = dt.Rows[0]["mobile"].ToString();
                            txtEmail.Text =  dt.Rows[0]["email_address"].ToString();
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try {

                if (PHCore_User.ChangeProfile(AppCode.strConnDB, PH_EncrptHelper.MD5Decryp(Request["id"]), txtContact.Text, txtEmail.Text, txtMobile.Text) > 0)
                    lblError.Text = ConfigurationManager.AppSettings["PH_Success_Message"];
                else lblError.Text = ConfigurationManager.AppSettings["PH_Error_Message"];
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }
    }
}