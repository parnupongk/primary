using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_BHUpload
    {
        public static int PH_BHTransaction_Insert(string strConnDB, string strYearWeek, string strUserId)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_BH_Transaction_Insert"
                    , new SqlParameter[] {new SqlParameter("@Week",strYearWeek),new SqlParameter("@UserID",strUserId) });
            }
            catch (Exception ex)
            {
                throw new Exception("PH_BHTransaction_Insert >> " + ex.Message);
            }
        }

        public static string PH_BHTransaction_InsertTMP(string strConnDB, AppCode_DS.PHDS_BHUpload.BH_Transaction_TMPRow dr)
        {
            try
            {
                return SqlHelper.ExecuteNonQueryTypedParams(strConnDB, "usp_BH_Transaction_TMP_Insert", dr).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_BHTransaction_InsertTMP >> " + ex.Message);
            }
        }

        public static DataTable PH_BHTransaction_SelTMP(string strConnDB, string strYearWeek, string strUserId)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_BH_Transaction_TMP_Select"
                                 , new SqlParameter[] {new SqlParameter("@Week",strYearWeek)
                                                        ,new SqlParameter("@UserID",strUserId)
                                                      });

                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw new Exception("PH_BHTransaction_SelTMP >> " + ex.Message);
            }
        }
    }
}
