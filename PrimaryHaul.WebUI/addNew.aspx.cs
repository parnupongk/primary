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
namespace PrimaryHaul.WebUI.Account
{
    public partial class addNew : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    /*eStatus = new PHCore_Status();
                    string strRoleId = PH_EncrptHelper.MD5Decryp(PH_Utility.GetCookie(Request, ConfigurationManager.AppSettings["PH_RoleUserCookie"]));
                    if( strRoleId != "" )
                    eStatus.RoleId = (PHCore_Status.RoleID)Enum.Parse(typeof(PHCore_Status.RoleID), strRoleId, true);*/

                    string[] type = (Request["type"] != null) ? Request["type"].Split(',') : null;
                    if (type != null && type[0] == PHCore_Status.RoleID.A1.ToString())
                    {
                        divContact.Visible = false;
                        divHaulier.Visible = false;
                        divVender.Visible = false;
                    }
                    else if (type != null && type[0] == PHCore_Status.RoleID.HL.ToString())
                    {
                        divVender.Visible = false;
                        divRole.Visible = false;
                    }
                    else if (type != null && type[0] == PHCore_Status.RoleID.VD.ToString())
                    {
                        divHaulier.Visible = false;
                        divRole.Visible = false;

                    }
                    else Response.Redirect("logout.aspx", false);

                    lblHeader.Text = (type != null) ? ConfigurationManager.AppSettings["PH_AddNew_" + type[0]] : "";
                    txtPasswrdExpried.Text = DateTime.Now.AddDays(AppCode.GetDayofPasswdExp(Page)).ToString(ConfigurationManager.AppSettings["PH_Date_format"]);
                }

                catch (Exception ex)
                {
                    lblErr.Text = ex.Message;
                    PH_ExceptionManager.WriteError(ex.Message);
                }
            }
        }

        private void GetUserName()
        {
            try
            {
                
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try {

                List<PrimaryHaul_WS.AppCode_DS.PHDS_User.User_VendorRow> drVenders = new List<PrimaryHaul_WS.AppCode_DS.PHDS_User.User_VendorRow>();
                PrimaryHaul_WS.AppCode_DS.PHDS_User.User_ProfileRow drProfile = new PrimaryHaul_WS.AppCode_DS.PHDS_User.User_ProfileDataTable().NewUser_ProfileRow();
                drProfile.UserType = "T";

                drProfile.RoleID = GetRoleId();//(Request["r"] != null && Request["r"] != "") ? Request["r"].ToString().ToUpper() : GetRoleId().ToString();
                drProfile.UserName = txtUserName.Text;
                drProfile.Passwd = PH_EncrptHelper.MD5Encryp(txtPassword.Text);
                drProfile.FullName_En = txtEngName.Text;
                drProfile.FullName_Th = txtTHAName.Text;
                drProfile.Mobile = txtMobile.Text;
                drProfile.EMail_Address = txtEmail.Text;
                drProfile.User_Status = rdoStatusA.Checked.ToString();
                drProfile.TaxID = txtHaulierCode.Text;
                drProfile.Contact_Person = txtContact.Text;
                drProfile.StampTime = DateTime.Now;
                drProfile.Passwd_Expired_Date = DateTime.Now;

                if( txtTaxId.Text != "" )
                {
                    PrimaryHaul_WS.AppCode_DS.PHDS_User.User_VendorRow drVendor;
                    string[] strVendorsId = txtTaxId.Text.Split(',');
                    foreach (string strVendor in strVendorsId)
                    {
                        if (strVendor.Trim() != "")
                        {
                            drVendor = new PrimaryHaul_WS.AppCode_DS.PHDS_User.User_VendorDataTable().NewUser_VendorRow();
                            drVendor.Vendor_Code = strVendor.Trim();
                            drVendor.StampTime = DateTime.Now;
                            drVenders.Add(drVendor);
                        }
                    }
                }

                PHCore_Status status = new PHCore_User().PH_Flow_UserInsert(AppCode.strConnDB, drProfile, drVenders);

                if(status.Status == PHCore_Status.SignInStatus.Success)
                {
                    Response.Redirect("addnew.aspx?" + Request.QueryString, false);
                }
                else
                {
                    lblError.Text = status.Message;
                }
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        private string GetRoleId()
        {
            try
            {
                //if (rdoRoleAdmin1.Checked) return PHCore_Status.RoleID.A1.ToString();
                if(rdoRoleAdmin2.Checked) return PHCore_Status.RoleID.A2.ToString();
                else
                {
                    string[] type = (Request["type"] != null) ? Request["type"].Split(',') : null;
                    return type[0];
                }
                //else if (rdoRolePH.Checked) return PHCore_Status.RoleID.HL;
                //return PHCore_Status.RoleID.VD;
            }
            catch(Exception ex)
            {
                throw new Exception("GetRoleId >>" + ex.Message);
            }
        }
    }
}