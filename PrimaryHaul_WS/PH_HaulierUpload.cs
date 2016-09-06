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
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, "usp_PrimaryHaul_FindRateCard"
                    , new SqlParameter[] {new SqlParameter("@Vendor_Code",dr.Vendor_Code)
                                            ,new SqlParameter("@Vendor_Name",dr.Vendor_Name)
                                            ,new SqlParameter("@Fuel_Rate",dr.Fuel_Rate)
                                            ,new SqlParameter("@Rate_Per_Unit",dr.Rate_Per_Unit)
                                            ,new SqlParameter("@RateType",dr.RateType)
                                            ,new SqlParameter("@Deliver_Location",dr.Delivery_Location)
                                            ,new SqlParameter("@Collection_Point",dr.Collection_Point)
                                            ,new SqlParameter("@PO_No",dr.PO_No)
                                            ,new SqlParameter("@Delivery_Ref",dr.Delivery_Ref)
                                        });

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
        public static string PH_HaulierUp_InsertTMP(string strConnDB, AppCode_DS.PHDS_HaulierUpload.TransportationRow dr)
        {
            try
            {
                return SqlHelper.ExecuteNonQueryTypedParams(strConnDB, "usp_PrimaryHaul_TransportationTMP_Insert", dr).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_HaulierUp_InsertTMP >> " + ex.Message);
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

        public static int PH_HaulierUp_Insert1(string strConnDB, string strYearWeek, string strAbbr, string strUserId)
        {
            try
            {
                int rtn = 0;
                using (SqlConnection sqlConn = new SqlConnection(strConnDB))
                {
                    if (sqlConn.State == ConnectionState.Closed) sqlConn.Open();
                    SqlCommand sqlComm = new SqlCommand("usp_PrimaryHaul_Transportation_Insert", sqlConn);
                    sqlComm.CommandText = "usp_PrimaryHaul_Transportation_Insert";
                    sqlComm.CommandType = CommandType.StoredProcedure;
                    sqlComm.CommandTimeout = 0;
                    sqlComm.Parameters.AddRange(new SqlParameter[] { new SqlParameter("@Year_Week_Upload", strYearWeek)
                                                        , new SqlParameter("@Haulier_Abbr", strAbbr)
                                                        , new SqlParameter("@UserID", strUserId)
                    });
                    rtn = sqlComm.ExecuteNonQuery();
                }

                return rtn;
            }
            catch(Exception ex) { throw new Exception(ex.Message); }
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
        public static int PH_HaulierUp_Verify(string strConnDB, string strYearWeek, string strAbbr, string strUserId)
        {
            try
            {
                int rtn = 0;
                using (SqlConnection sqlConn = new SqlConnection(strConnDB))
                {
                    if (sqlConn.State == ConnectionState.Closed) sqlConn.Open();
                    SqlCommand sqlComm = new SqlCommand("usp_PrimaryHaul_TransportationTMP_Verify", sqlConn);
                    sqlComm.CommandText = "usp_PrimaryHaul_TransportationTMP_Verify";
                    sqlComm.CommandType = CommandType.StoredProcedure;
                    sqlComm.CommandTimeout = 0;
                    sqlComm.Parameters.AddRange(new SqlParameter[] { new SqlParameter("@Year_Week_Upload", strYearWeek)
                                                        , new SqlParameter("@Haulier_Abbr", strAbbr)
                                                        , new SqlParameter("@UserID", strUserId)
                    });
                rtn = sqlComm.ExecuteNonQuery();
                }



                //int rtn = SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_TransportationTMP_Verify"
                //                 , new SqlParameter[] {new SqlParameter("@Year_Week_Upload",strYearWeek)
                 //                                       ,new SqlParameter("@Haulier_Abbr",strAbbr)
                //                                        ,new SqlParameter("@UserID",strUserId)
                //                                      });

                return rtn;
            }
            catch (Exception ex)
            {
                throw new Exception("PH_HaulierUp_Verify >> " + ex.Message);
            }
        }
        public static int PH_HaulierUp_DelTMP(string strConnDB, string strYearWeek, string strAbbr, string strUserId)
        {
            try
            {
                int rtn = SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_TransportationTMP_Delete"
                                 , new SqlParameter[] {new SqlParameter("@Year_Week_Upload",strYearWeek)
                                                        ,new SqlParameter("@Haulier_Abbr",strAbbr)
                                                        ,new SqlParameter("@UserID",strUserId)
                                                      });

                return rtn;
            }
            catch (Exception ex)
            {
                throw new Exception("PH_HaulierUp_DelTMP >> " + ex.Message);
            }
        }
        public static DataTable PH_HaulierUp_SelTMP(string strConnDB,string strYearWeek,string strAbbr,string strUserId)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_TransportationTMP_Select"
                                 ,new SqlParameter[] {new SqlParameter("@Year_Week_Upload",strYearWeek)
                                                        ,new SqlParameter("@Haulier_Abbr",strAbbr)
                                                        ,new SqlParameter("@UserID",strUserId)
                                                      });

                return ds.Tables[0];
            }
            catch(Exception ex)
            {
                throw new Exception("PH_HaulierUp_SelAll >> " + ex.Message);
            }
        }
    }
}
