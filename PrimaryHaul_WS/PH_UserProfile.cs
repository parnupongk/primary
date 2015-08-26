using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
namespace PrimaryHaul_WS
{
    public class PH_UserProfile
    {
        /// <summary>
        /// PH_UserProfile_GetMaxID
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <returns></returns>
        public static int PH_UserProfile_GetMaxID(string strConnDB)
        {
            try
            {
                object rtn ;
                rtn = SqlHelper.ExecuteScalar(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_UserProfileGetID").ToString() ;
                int id = rtn == null || rtn.ToString() == "" ? 0 : int.Parse(rtn.ToString()) + 1;
                return id;
            }
            catch(Exception ex)
            {
                throw new Exception("PH_UserProfile_GetMaxID >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_UserProfile_SelByUserId
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strUserId"></param>
        /// <returns></returns>
        public static DataTable PH_UserProfile_SelByUserId(string strConnDB,string strUserId)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_UserProfileSelByUId"
                    , new SqlParameter[] { new SqlParameter("@UserID", strUserId)});

                return ds.Tables.Count > 0 ? ds.Tables[0] :null;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// PH_UserProfile_ChangeProfile
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strUserId"></param>
        /// <param name="strContact"></param>
        /// <param name="strEmail"></param>
        /// <param name="strMobile"></param>
        /// <returns></returns>
        public static int PH_UserProfile_ChangeProfile(string strConnDB,string strUserId,string strContact,string strEmail,string strMobile)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_UserProfileChangeProfile"
                    , new SqlParameter[] {new SqlParameter("@UserID",strUserId)
                                          ,new SqlParameter("@Contact_Person",strContact)
                                          ,new SqlParameter("@Mobile",strMobile)
                                          ,new SqlParameter("@EMail_Address",strEmail)
                                          ,new SqlParameter("@StampTime",DateTime.Now)
                                         });
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// PH_UserProfile_ChangePasswd
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strUserId"></param>
        /// <param name="strPasswd"></param>
        /// <param name="dtPasswdExp"></param>
        /// <returns></returns>
        public static int PH_UserProfile_ChangePasswd(string strConnDB,string strUserId,string strPasswd,DateTime dtPasswdExp)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_UserProfileChangePasswd"
                    , new SqlParameter[] {new SqlParameter("@UserID",strUserId)
                                          ,new SqlParameter("@Passwd",strPasswd)
                                          ,new SqlParameter("@Passwd_Expired_Date",dtPasswdExp)
                                          ,new SqlParameter("@StampTime",DateTime.Now)
                                         });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_UserProfile_ChangePasswd >>"+ex.Message);
            }
        }

        public static DataTable PH_UserProfile_SigIn(string strConnDB, string strUserName, string strPassword)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, "usp_PrimaryHaul_UserSigIn"
                    , new SqlParameter[] { new SqlParameter("@strUserName",strUserName)
                                            ,new SqlParameter("@strPassword",strPassword)
                                         });
                //AppCode_DS.PHDS_User.User_ProfileDataTable dt = new AppCode_DS.PHDS_User.User_ProfileDataTable();
                //dt = (AppCode_DS.PHDS_User.User_ProfileDataTable)ds.Tables[0];

                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw new Exception("PH_UserProfile_SigIn >>" + ex.Message);
            }

        }

        /// <summary>
        /// PH_UserProfile_Insert
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drProfile"></param>
        /// <returns></returns>
        public static string PH_UserProfile_Insert(string strConnDB,AppCode_DS.PHDS_User.User_ProfileRow drProfile)
        {
            try
            {
                return SqlHelper.ExecuteNonQueryTypedParams(strConnDB, "usp_PrimaryHaul_UserProfileInsert", drProfile).ToString();
            }
            catch(Exception ex)
            {
                throw new Exception("PH_UserProfile_Insert >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_UserProfile_Delete
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drProfile"></param>
        /// <returns></returns>
        public static string PH_UserProfile_Delete(string strConnDB, AppCode_DS.PHDS_User.User_ProfileRow drProfile)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, "sp_userprofile_delete",new SqlParameter[] {new SqlParameter("@UserID",drProfile.UserID) } ).ToString();
            }
            catch(Exception ex)
            {
                throw new Exception("PH_UserProfile_Delete >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_UserProfile_Update
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drProfile"></param>
        /// <returns></returns>
        public static string PH_UserProfile_Update(string strConnDB, AppCode_DS.PHDS_User.User_ProfileRow drProfile)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, "sp_userprofile_update"
                    ,new SqlParameter[] {new SqlParameter("@UserID", drProfile.UserID)
                                        ,new SqlParameter("@UserType",drProfile.UserType)
                                        }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_UserProfile_Delete >>" + ex.Message);
            }
        }

    }
}
