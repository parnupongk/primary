using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_RateCardInfo
    {
        public static DataTable PH_RateType_SelAll(string strConnDB)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateTypeSelectAll");

                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static DataTable PH_DC_SelAll(string strConnDB)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_DCSelectAll");

                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static DataTable PH_Collection_SelAll(string strConnDB)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_CollectionSelectAll");

                return ds.Tables[0];
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static int PH_RateCard_Update(string strConnDB,string strRateCardID,DateTime dEndDate)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateCardUpdate"
                    , new SqlParameter[] { new SqlParameter("@RateCard_ID", strRateCardID)
                                            ,new SqlParameter("@EndDate",dEndDate)
                                        });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_RateCard_Update >> " + ex.Message);
            }
        }
        public static DataTable PH_RateCard_SelByVendorName(string strConnDB,string strVendorName)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateCardSelAll"
                    ,new SqlParameter[] {new SqlParameter("@vendor_name", strVendorName) });

                return ds.Tables[0];
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public static int PH_RateCard_Insert(string strConnDB,DataRow dr)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateCardInsert"
                    , new SqlParameter[] {new SqlParameter("@Vendor_Code",dr[0].ToString())
                                            ,new SqlParameter("@Vendor_Name",dr[1].ToString())
                                            ,new SqlParameter("@Collection_Point",dr[4].ToString())
                                            ,new SqlParameter("@Collection_Point_Replace",dr[4].ToString().Replace(" ",""))
                                            ,new SqlParameter("@DC_ABBR",dr[5].ToString())
                                            ,new SqlParameter("@Transporter_Name",dr[6].ToString())
                                            ,new SqlParameter("@Transporter_Desc",dr[11].ToString())
                                            ,new SqlParameter("@Buy_RateType",dr[8].ToString())
                                            ,new SqlParameter("@Buy_Rate",PH_Utility.StringtoDecimal( dr[7].ToString()))
                                            ,new SqlParameter("@Buy_RateType_Desc",dr[9])
                                            ,new SqlParameter("@Buy_Load_Type",dr[10])
                                            ,new SqlParameter("@Sell_RateType",dr[13])
                                            ,new SqlParameter("@Sell_Rate",PH_Utility.StringtoDecimal( dr[12].ToString()))
                                            ,new SqlParameter("@Currency",dr[14])
                                            ,new SqlParameter("@Fuel_Rate_From",PH_Utility.StringtoDecimal( dr[15].ToString()))
                                            ,new SqlParameter("@Fuel_Rate_To",PH_Utility.StringtoDecimal( dr[16].ToString()))
                                            ,new SqlParameter("@StartDate",dr[2])
                                            ,new SqlParameter("@EndDate",dr[3])
                                            ,new SqlParameter("@StamptTime",DateTime.Now)

                                        });
            }
            catch(Exception ex)
            {
                throw new Exception("PH_RateCard_Insert >> " + ex.Message);
            }
        }

        public static string PH_CollectionPoint_Insert(string strConnDB, string strCollPoint)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_CollectionPointInsert"
                       , new SqlParameter[] {new SqlParameter("@Collection_Point",strCollPoint)
                                            ,new SqlParameter("@StampTime",DateTime.Now)

                        }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_CollectionPoint_Insert >> " + ex.Message);
            }
        }

        public static string PH_RateType_Insert(string strConnDB, string strRateType)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_RateTypeInsert"
                       , new SqlParameter[] {new SqlParameter("@RateType",strRateType)
                                            ,new SqlParameter("@StampTime",DateTime.Now)

                        }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_RateType_Insert >> " + ex.Message);
            }
        }

    }
}
