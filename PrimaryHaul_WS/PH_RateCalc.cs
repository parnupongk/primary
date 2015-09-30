using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_RateCalc
    {

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

        public static int PH_RateCalc_TransporationCalc(string strConnDB,DataRow drTrans)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateCalcUpdateTransportation"
                    , new SqlParameter[] {new SqlParameter("@TransID",drTrans["transid"])
                                            ,new SqlParameter("@Vendor_Code",drTrans["Vendor_Code"])
                                            ,new SqlParameter("@Collection_Point",drTrans["Collection_Point"])
                                            ,new SqlParameter("@Delivery_Location",drTrans["Delivery_Location"])
                                            ,new SqlParameter("@DC_No",drTrans["DC_No"])
                                            ,new SqlParameter("@RateType",drTrans["RateType"])
                                            ,new SqlParameter("@Rate_Per_Unit",drTrans["Rate_Per_Unit"])
                                            ,new SqlParameter("@Fuel_Rate",drTrans["Fuel_Rate"])
                                            ,new SqlParameter("@NoOfQty",drTrans["No_Of_Qty"])
                                        });
            }
            catch(Exception ex)
            {
                throw new Exception(" PH_RateCalc_TransporationCalc >> " + ex.Message);
            }
        }


    }
}
