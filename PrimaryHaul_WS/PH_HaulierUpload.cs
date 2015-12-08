using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
namespace PrimaryHaul_WS
{
    public class PH_HaulierUpload
    {

        public static string PH_HaulierUp_FindRateCard(string strConnDB, AppCode_DS.PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDatasetTypedParams(strConnDB, "usp_PrimaryHaul_FindRateCard", dr);

                return ds.Tables[0].Rows.Count > 0 ? "" : "err_miss";
            }
            catch(Exception ex)
            {
                throw new Exception("PH_HaulierUp_FindRateCard >> " + ex.Message);
            }
        }
        /*
        public static string PH_HaulierUp_FindFresh(string strConnDB, AppCode_DS.PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_FindRateCard_Fresh"
                    , new SqlParameter[] {new SqlParameter("@Vendor_Code",dr.Vendor_Code)
                                            ,new SqlParameter("@RateType",dr.RateType)
                                            ,new SqlParameter("@Deliver_Location",dr.Delivery_Location)
                                            ,new SqlParameter("@Collection_Point",dr.Collection_Point)
                                         });

                return ds.Tables[0].Rows.Count > 0 ? "" : "err_miss";
            }
            catch (Exception ex)
            {
                throw new Exception("PH_HaulierUp_FindFresh >> " + ex.Message);
            }
        }

        public static string PH_HaulierUp_FindRTN(string strConnDB, AppCode_DS.PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_FindRateCard_RTN"
                    , new SqlParameter[] {new SqlParameter("@Vendor_Code",dr.Vendor_Code)
                                            ,new SqlParameter("@RateType",dr.RateType)
                                            ,new SqlParameter("@Rate_Per_Unit",dr.Rate_Per_Unit)
                                            ,new SqlParameter("@Collection_Point",dr.Collection_Point)
                                         });

                return ds.Tables[0].Rows.Count > 0 ? "" : "err_miss";
            }
            catch (Exception ex)
            {
                throw new Exception("PH_HaulierUp_FindRTN >> " + ex.Message);
            }
        }*/

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
