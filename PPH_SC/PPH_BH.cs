using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;


namespace PPH_SC
{
    public class PPH_BH
    {
        public static Boolean insert_ratecard(string strConnDB, string Vendor_Code, string Vendor_Name, string DC_No, string ChargeType, string Rate, string Unloading_Cost, string Income_Type, string StartDate, string EndDate)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();         
            try
            {
                SqlCommand cmd = new SqlCommand("usp_BH_RateCard_Insert", objConn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Vendor_Code", SqlDbType.VarChar).Value = Vendor_Code;
                cmd.Parameters.Add("@Vendor_Name", SqlDbType.VarChar).Value = Vendor_Name;
                cmd.Parameters.Add("@DC_No", SqlDbType.VarChar).Value = DC_No;
                cmd.Parameters.Add("@ChargeType", SqlDbType.VarChar).Value = ChargeType;
                cmd.Parameters.Add("@Rate", SqlDbType.VarChar).Value = Rate;
                cmd.Parameters.Add("@Unloading_Cost", SqlDbType.VarChar).Value = Unloading_Cost;
                cmd.Parameters.Add("@Income_Type", SqlDbType.VarChar).Value = Income_Type;
                cmd.Parameters.Add("@StartDate", SqlDbType.VarChar).Value = StartDate;
                cmd.Parameters.Add("@EndDate", SqlDbType.VarChar).Value = EndDate;
                cmd.ExecuteNonQuery();
                
                objConn.Close();
                objConn = null;
                return true;
            }
            catch (Exception ex)
            {
                objConn.Close();
                objConn = null;
                PrimaryHaul_WS.PH_ExceptionManager.WriteError(ex.Message);
                return false;
            }
        }

        public static Boolean update_ratecard(string strConnDB, string ratecardID, string startDate, string endDate)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("usp_BH_RateCard_Update_Date", objConn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RateCard_ID", ratecardID);
                cmd.Parameters.AddWithValue("@StartDate", DateTime.ParseExact(startDate, "d/M/yyyy", new CultureInfo("en-US")));
                cmd.Parameters.AddWithValue("@EndDate", DateTime.ParseExact(endDate, "d/M/yyyy", new CultureInfo("en-US")));
                cmd.ExecuteNonQuery();

                objConn.Close();
                objConn = null;
                return true;
            }
            catch (Exception ex)
            {
                objConn.Close();
                objConn = null;
                PrimaryHaul_WS.PH_ExceptionManager.WriteError(ex.Message);
                return false;
            }
        }

        public static SqlDataReader get_bh_ratecard(string strConnDB, string txt_search)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            SqlCommand cmd = new SqlCommand("usp_BH_RateCard_FindSelect", objConn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = txt_search;
            return cmd.ExecuteReader();
        }

        public static Boolean insert_rams(string strConnDB, string DC_No, string Week, string Vendor_Code, string Dept_Code, string Dept_Name, string Class_Name, string Style, string Desciptions, string Rec_Case, string BH_Rate, string BH_Amount, string PO_No, string Del_Date, string File_Name, string UserID)
        {
            if (BH_Rate == "") { BH_Rate = "0"; }
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("usp_BH_RAMS_Insert", objConn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DC_No", int.Parse(DC_No));
                cmd.Parameters.AddWithValue("@Week", Week);
                cmd.Parameters.AddWithValue("@Vendor_Code", Vendor_Code);
                cmd.Parameters.AddWithValue("@Dept_Code", Dept_Code);
                cmd.Parameters.AddWithValue("@Dept_Name", Dept_Name);
                cmd.Parameters.AddWithValue("@Class_Name", Class_Name);
                cmd.Parameters.AddWithValue("@Style", Style);
                cmd.Parameters.AddWithValue("@Desciptions", Desciptions);
                cmd.Parameters.AddWithValue("@Rec_Case", Math.Round(decimal.Parse(Rec_Case), 2));
                cmd.Parameters.AddWithValue("@BH_Rate", decimal.Parse(BH_Rate));
                cmd.Parameters.AddWithValue("@BH_Amount", BH_Amount);
                cmd.Parameters.AddWithValue("@PO_No", PO_No);
                cmd.Parameters.AddWithValue("@Del_Date", Del_Date);
                cmd.Parameters.AddWithValue("@File_Name", File_Name);
                cmd.Parameters.AddWithValue("@UserID", int.Parse(UserID));
                cmd.ExecuteNonQuery();

                objConn.Close();
                objConn = null;
                return true;
            }
            catch (Exception ex)
            {
                objConn.Close();
                objConn = null;
                PrimaryHaul_WS.PH_ExceptionManager.WriteError(ex.Message);
                return false;
            }
        }

        public static SqlDataReader get_bh_rams(string strConnDB, string txt_week, string txt_vendor)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            SqlCommand cmd_rams = new SqlCommand("usp_BH_RAMS_FindSelect", objConn);
            cmd_rams.CommandType = CommandType.StoredProcedure;
            cmd_rams.Parameters.Add("@YearWeek", SqlDbType.VarChar).Value = txt_week;
            cmd_rams.Parameters.Add("@KeySearch", SqlDbType.VarChar).Value = txt_vendor;
            return cmd_rams.ExecuteReader();
        }

        public static SqlDataReader get_kpi_report(string strConnDB, string txt_week)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            SqlCommand cmd_kpireport = new SqlCommand("usp_BH_Transaction_Select_KPI", objConn);
            cmd_kpireport.CommandType = CommandType.StoredProcedure;
            cmd_kpireport.Parameters.Add("@Week", SqlDbType.VarChar).Value = txt_week;
            return cmd_kpireport.ExecuteReader();
        }  
    }
}
