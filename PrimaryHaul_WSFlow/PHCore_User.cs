using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using PrimaryHaul_WS;
using PrimaryHaul_WS.AppCode_DS;
namespace PrimaryHaul_WSFlow
{
    public class PHCore_User
    {
        public static DataTable SelAllUserName(string strConnDB)
        {
            try
            {
                return PH_UserProfile.PH_UserProfile_SelUserName(strConnDB);
            }
            catch(Exception ex)
            {
                throw new Exception("SelAllUserName >>" + ex.Message);
            }
        }

        /// <summary>
        /// SelByUserId
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strUserId"></param>
        /// <returns></returns>
        public  static DataTable SelByUserId(string strConnDB,string strUserId)
        {
            try
            {
                return PH_UserProfile.PH_UserProfile_SelByUserId(strConnDB, PH_EncrptHelper.MD5Decryp(strUserId));
            }
            catch(Exception ex)
            {
                throw new Exception("SelByUserId >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_Flow_UserInsert
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drProfile"></param>
        /// <param name="drVenders"></param>
        /// <returns></returns>
        public PHCore_Status PH_Flow_UserInsert(string strConnDB,PHDS_User.User_ProfileRow drProfile , List<PHDS_User.User_VendorRow> drVenders)
        {
            PHCore_Status status = new PHCore_Status();
            try
            {
                drProfile.UserID = PH_UserProfile.PH_UserProfile_GetMaxID(strConnDB);
                PH_UserProfile.PH_UserProfile_Insert(strConnDB, drProfile);

                if(drVenders != null && drVenders.Count >0 )
                {

                    foreach( PHDS_User.User_VendorRow dr in drVenders )
                    {
                        dr.UserID = drProfile.UserID;
                        PH_UserVendor.PH_UserVendor_Insert(strConnDB, dr);
                    }
                }

                status.Status = PHCore_Status.SignInStatus.Success;

            }
            catch(Exception ex)
            {
                status.Status = PHCore_Status.SignInStatus.Failure;
                status.Message = ex.Message;
            }
            return status;
        }

        /// <summary>
        /// ChangePasswd
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strUserId"></param>
        /// <param name="strPasswd"></param>
        /// <param name="dtPasswdExp"></param>
        /// <returns></returns>
        public static int ChangePasswd(string strConnDB, string strUserId, string strPasswd, DateTime dtPasswdExp)
        {
            try
            {
                return PH_UserProfile.PH_UserProfile_ChangePasswd(strConnDB, strUserId, strPasswd, dtPasswdExp);
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// ChangeProfile
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strUserId"></param>
        /// <param name="strContact"></param>
        /// <param name="strEmail"></param>
        /// <param name="strMobile"></param>
        /// <returns></returns>
        public static int ChangeProfile(string strConnDB, string strUserId, string strContact, string strEmail,string strMobile)
        {
            try
            {
                return PH_UserProfile.PH_UserProfile_ChangeProfile(strConnDB, strUserId,strContact,strEmail,strMobile);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
