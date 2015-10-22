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

                    #region Check Type
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
                        divVender.Visible = false;

                    }
                    else Response.Redirect("logout.aspx", false);
                    #endregion


                    if (PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A2")
                    {
                        btnSubmit.Style["visibility"] = "hidden";
                    }
                    lblHeader.Text = (type != null) ? ConfigurationManager.AppSettings["PH_AddNew_" + type[0]] : "";
                    txtPasswrdExpried.Text = DateTime.Now.AddDays(AppCode.GetDayofPasswdExp(Page)).ToString("dd/MM/yyyy");
                }

                catch (Exception ex)
                {
                    lblError.Text = ex.Message;
                    PH_ExceptionManager.WriteError(ex.Message);
                }
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if(PHCore_User.SelAllUserName(AppCode.strConnDB, txtUserName.Text).Trim() != "")
                {
                    lblErrUserName.Text = ConfigurationManager.AppSettings["PH_AddNew_UserName_Err"];
                }else if(GetRoleId() == PHCore_Status.RoleID.HL.ToString() && PH_HaulierInfo.PH_Haulier_SelByTaxId(AppCode.strConnDB, txtHaulierCode.Text).Trim() == "" )
                {
                    lblErrHaulierCode.Text = ConfigurationManager.AppSettings["PH_AddNew_Haulier_Err"];
                }
                else InsertUserProfile();

            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        private void InsertUserProfile()
        {
            try
            {
                if (!Page.IsValid) return;

                List<PrimaryHaul_WS.AppCode_DS.PHDS_User.User_VendorRow> drVenders = new List<PrimaryHaul_WS.AppCode_DS.PHDS_User.User_VendorRow>();
                PrimaryHaul_WS.AppCode_DS.PHDS_User.User_ProfileRow drProfile = new PrimaryHaul_WS.AppCode_DS.PHDS_User.User_ProfileDataTable().NewUser_ProfileRow();


                #region Row Profile
                drProfile.UserType = GetRoleId();
                drProfile.RoleID = GetRoleId();//(Request["r"] != null && Request["r"] != "") ? Request["r"].ToString().ToUpper() : GetRoleId().ToString();
                drProfile.UserName = txtUserName.Text;
                drProfile.Passwd = PH_EncrptHelper.MD5Encryp(ConfigurationManager.AppSettings["PH_AddNew_Password_Default"]);
                drProfile.FullName_En = txtEngName.Text;
                drProfile.FullName_Th = txtTHAName.Text;
                drProfile.Mobile = txtMobile.Text;
                drProfile.EMail_Address = txtEmail.Text;
                drProfile.User_Status = rdoStatusA.Checked?"A":"D";
                drProfile.TaxID = txtHaulierCode.Text;
                drProfile.Contact_Person = txtContact.Text;
                drProfile.StampTime = DateTime.Now;
                drProfile.Passwd_Expired_Date = DateTime.Now;//chkForepasswrd.Checked ? DateTime.Now : DateTime.ParseExact(txtPasswrdExpried.Text, ConfigurationManager.AppSettings["PH_Date_format"], null) ;
                #endregion

                #region Vendor
                if (txtTaxId.Text != "")
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
                #endregion

                PHCore_Status status = new PHCore_User().PH_Flow_UserInsert(AppCode.strConnDB, drProfile, drVenders);

                if (status.Status == PHCore_Status.SignInStatus.Success)
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertmsg", "alertMessage('Save Success');", true);
                    //Response.Redirect("addnew.aspx?" + Request.QueryString, false);
                }
                else
                {
                    lblError.Text = status.Message;
                }
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public string GetRoleId()
        {
            try
            {
                if(rdoRoleAdmin2.Checked) return PHCore_Status.RoleID.A2.ToString();
                else
                {
                    string[] type = (Request["type"] != null) ? Request["type"].Split(',') : null;
                    return type[0];
                }
            }
            catch(Exception ex)
            {
                return "";
                //throw new Exception("GetRoleId >>" + ex.Message);
            }
        }
    }
}