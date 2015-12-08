using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_RateCalc
    {
        public static int PH_RateCacl_TransportDelete(string strConnDB,string strAbbr,string strYearWeek)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_DeleteTransportation"
                    , new SqlParameter[] {new SqlParameter("@Haulier_Abbr",strAbbr)
                                        , new SqlParameter("@Year_Week_Upload",strYearWeek)
                                        });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_RateCacl_TransportDelete >> " + ex.Message);
            }
        }

        public static int PH_RateCaclAdj_TransportUpdate(string strConnDB, string strHaulier, string strYearWeek,string strVendorCode)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_ReCalculate"
                    , new SqlParameter[] {new SqlParameter("@Haulier_Abbr",strHaulier)
                                        , new SqlParameter("@Date_Week",strYearWeek)
                                        , new SqlParameter("@vendor_code",strVendorCode)
                                        });
            }
            catch (Exception ex)
            {
                throw new Exception("PH_RateCaclAdj_TransportInsert >> " + ex.Message);
            }
        }
        public static int PH_RateCaclAdj_TransportInsert(string strConnDB,string strTransId,int iUserId,int iNoQty)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_TransportataionInsertByAdj"
                    , new SqlParameter[] {new SqlParameter("@transID",strTransId)
                                        , new SqlParameter("@userID",iUserId)
                                        , new SqlParameter("@no_of_qty",iNoQty)
                                        });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_RateCaclAdj_TransportInsert >> " + ex.Message);
            }
        }

        public static DataSet PH_RateCalcAdj_TransportSel(string strConnDB,string strHalier,string strVendor,string strYearWeek)
        {
            try
            {
                return SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_TransportationSelByAdj"
                    ,new SqlParameter[] {new SqlParameter("@Haulier_Abbr",strHalier)
                                        ,new SqlParameter("@Vendor_Code",strVendor)
                                        ,new SqlParameter("@Year_Week_Upload",strYearWeek)
                                        });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_RateCalcAdj_TransportSel >> " + ex.Message);
            }
        }

        public static DataSet PH_RateCalc_DateWeekSelAll(string strConnDB)
        {
            try
            {
                return SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_DateWeekInfoSelAll");
            }
            catch(Exception ex)
            {
                throw new Exception("PH_RateCalc_DateWeekSelAll >> " + ex.Message);
            }
        }
        public static DataSet PH_ReateCalc_HaulierSelByDateWeek(string strConnDB,string strDateWeek)
        {
            try
            {
                return SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateCalSelListHaulier",
                    new SqlParameter[] {new SqlParameter("@year_week_upload", strDateWeek) });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_ReateCalc_HaulierSelByDateWeek >> " + ex.Message);
            }
        }

        public static int PH_RateCalc_TransporationCalc(string strConnDB,DataRow drTrans,string strWeek)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateCalcUpdateTransportation"
                    , new SqlParameter[] {new SqlParameter("@Haulier_Abbr",drTrans["Haulier_Abbr"])
                                            ,new SqlParameter("@date_week",strWeek)
                                        });
            }
            catch(Exception ex)
            {
                throw new Exception(" PH_RateCalc_TransporationCalc >> " + ex.Message);
            }
        }


    }
}
