using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
namespace PrimaryHaul_WS
{
    public class PH_UserVendor
    {

        /// <summary>
        /// PH_UserVendor_SelectAll
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <returns></returns>
        public static DataTable PH_UserVendor_SelectAll(string strConnDB)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_VendorSelectAll");

                return (ds.Tables.Count > 0) ? ds.Tables[0]:null;
                

            }
            catch(Exception ex)
            {
                throw new Exception("PH_UserVendor_SelectAll >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_UserVendor_Insert
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drVendor"></param>
        /// <returns></returns>
        public static string PH_UserVendor_Insert(string strConnDB, AppCode_DS.PHDS_User.User_VendorRow drVendor)
        {
            try
            {
                return SqlHelper.ExecuteNonQueryTypedParams(strConnDB, "usp_PrimaryHaul_UserVendorInsert", drVendor).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_UserVendor_Insert >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_UserVendor_Delete
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drVendor"></param>
        /// <returns></returns>
        public static string PH_UserVendor_Delete(string strConnDB, AppCode_DS.PHDS_User.User_VendorRow drVendor)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, "sp_UserVendor_delete", new SqlParameter[] { new SqlParameter("@UserID", drVendor.Vendor_Code) }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_UserVendor_Delete >>" + ex.Message);
            }
        }

        /// <summary>
        /// PH_UserVendor_Update
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="drVendor"></param>
        /// <returns></returns>
        public static string PH_UserVendor_Update(string strConnDB, AppCode_DS.PHDS_User.User_VendorRow drVendor)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, "sp_UserVendor_update"
                    , new SqlParameter[] {new SqlParameter("@UserID", drVendor.UserID)
                                        ,new SqlParameter("@UserType",drVendor.StampTime)
                                        }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_UserVendor_Delete >>" + ex.Message);
            }
        }
    }
}
