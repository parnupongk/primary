﻿using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_BHCalc
    {

        public static DataTable PH_BHTransCacl_Sel(string strConnDB, string strYearWeek)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_BH_Transaction_Select_Calc"
                                 , new SqlParameter[] {new SqlParameter("@Week",strYearWeek)
                                                      });

                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw new Exception("PH_BHCacl_Sel >> " + ex.Message);
            }
        }

        public static int PH_BHTrans_Calc(string strConnDB, string strYearWeek)
        {
            try
            {
                int rtn = SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_BH_Transaction_Calc"
                                 , new SqlParameter[] {new SqlParameter("@Tesco_Week",strYearWeek)
                                                      });

                return rtn;
            }
            catch (Exception ex)
            {
                throw new Exception("PH_BHTrans_Calc >> " + ex.Message);
            }
        }

        public static int PH_BHTransCalc_Delete(string strConnDB, string strYearWeek,string strFileName)
        {
            try
            {
                int rtn = SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_BH_Transaction_Delete"
                                 , new SqlParameter[] {new SqlParameter("@Week",strYearWeek)
                                 , new SqlParameter("@File_Name",strFileName)
                                                      });

                return rtn;
            }
            catch (Exception ex)
            {
                throw new Exception("PH_BHTransCalc_Delete >> " + ex.Message);
            }
        }
    }
}