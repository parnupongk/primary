using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
namespace PrimaryHaul_WS
{
    public class PH_HaulierUpload
    {
        public static string PH_HaulierUpLog_Insert(string strConnDB,int iUserId,string strTescoWeek,string strFileName,string strHaulierAbbr)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_HaulierUpLogInsert"
                    , new SqlParameter[] {new SqlParameter("@Haulier_UserID",iUserId)
                                        , new SqlParameter("Haulier_Abbr",strHaulierAbbr)
                                        , new SqlParameter("@Tesco_Year_Week",strTescoWeek)
                                        ,new SqlParameter("@File_Name",strFileName)
                                        ,new SqlParameter("@Upload_DateTime",DateTime.Now)
                                        }).ToString();
            }
            catch(Exception ex)
            {
                throw new Exception("PH_HaulierUpLog_Insert >> " + ex.Message);
            }
        }
        public static string PH_HaulierUp_Insert(string strConnDB,AppCode_DS.PHDS_HaulierUpload.TransportationRow dr )
        {
            try
            {
                return SqlHelper.ExecuteNonQueryTypedParams(strConnDB, "usp_PrimaryHaul_TransportationInsert", dr).ToString();
            }
            catch(Exception ex)
            {
                throw new Exception("PH_HaulierUp_Insert >> " + ex.Message);
            }
        }

        public static string PH_HaulierUp_GetDateWeek(string strConnDB)
        {
            try
            {
                string rtn = "";
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_DateWeekInfoSel");
                if(ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    rtn = ds.Tables[0].Rows[0]["Tesco_Year"].ToString() + ds.Tables[0].Rows[0]["Tesco_Week"].ToString();
                }
                return rtn;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static DataTable PH_HaulierUp_SelAll(string strConnDB)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_HaulierUpSelectAll");

                return ds.Tables[0];
            }
            catch(Exception ex)
            {
                throw new Exception("PH_HaulierUp_SelAll >> " + ex.Message);
            }
        }
    }
}
