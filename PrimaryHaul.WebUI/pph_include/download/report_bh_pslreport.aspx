<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_bh_pslreport.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.report_bh_pslreport" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Linq"%>
<%@ Import Namespace="System.Collections.Generic"%>
<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<% 
    string str_wkstart = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkstart"] as string)) { str_wkstart = Request.QueryString["wkstart"].ToString(); }
    string str_wkend = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkend"] as string)) { str_wkend = Request.QueryString["wkend"].ToString(); }
    string str_dc = "0"; if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { str_dc = Request.QueryString["dc"].ToString(); }
%>
<body>
<% if(Convert.ToInt32(str_wkstart) <= Convert.ToInt32(str_wkend)){ int i;%>

        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Income</td> 
            <%  SqlCommand rs_count1 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count1.CommandType = CommandType.StoredProcedure; rs_count1.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count1.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol1 = rs_count1.ExecuteReader(); int iCol1 = 0; while (countCol1.Read()) { iCol1++; } countCol1.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol1 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc1 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc1.CommandType = CommandType.StoredProcedure;  rs_col_dc1.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc1.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc1 = rs_col_dc1.ExecuteReader(); while (col_dc1.Read()){ %>
                 <td style="text-align:center;"><%=col_dc1["DC_NO"].ToString() %></td> 
            <% } col_dc1.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail1 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail1.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail1.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail1.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail1 = rs_col_dcDetail1.ExecuteReader(); while (col_dcDetail1.Read()){ %>
                 <td style="text-align:right;">
                 <% 
                    SqlCommand rs_detail1 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail1.CommandType = CommandType.StoredProcedure;
                    rs_detail1.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail1.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail1.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail1["DC_NO"].ToString()) + "");
                    rs_detail1.Parameters.AddWithValue("@Data", "Income");
                    SqlDataReader obj_detail1 = rs_detail1.ExecuteReader();
                    if (obj_detail1.HasRows)
                    {
                        obj_detail1.Read();
                        Response.Write(Convert.ToDouble(obj_detail1["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail1.Close();
                    }
                 %>
                 </td>
            <% } col_dcDetail1.Close(); %>
        </tr>
        <% } %>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Unloading</td> 
            <%  SqlCommand rs_count2 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count2.CommandType = CommandType.StoredProcedure; rs_count2.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count2.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol2 = rs_count1.ExecuteReader(); int iCol2= 0; while (countCol2.Read()) { iCol2++; } countCol2.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol2 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc2 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc2.CommandType = CommandType.StoredProcedure;  rs_col_dc2.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc2.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc2 = rs_col_dc2.ExecuteReader(); while (col_dc2.Read()){ %>
                 <td style="text-align:center;"><%=col_dc2["DC_NO"].ToString() %></td> 
            <% } col_dc2.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail2 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail2.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail2.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail2.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail2 = rs_col_dcDetail2.ExecuteReader(); while (col_dcDetail2.Read()){ %>
                 <td style="text-align:right;">
                 <% 
                    SqlCommand rs_detail2 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail2.CommandType = CommandType.StoredProcedure;
                    rs_detail2.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail2.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail2.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail2["DC_NO"].ToString()) + "");
                    rs_detail2.Parameters.AddWithValue("@Data", "Unloading");
                    SqlDataReader obj_detail2 = rs_detail2.ExecuteReader();
                    if (obj_detail2.HasRows)
                    {
                        obj_detail2.Read();
                        Response.Write(Convert.ToDouble(obj_detail2["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail2.Close();
                    }
                 %>
                 </td>
            <% } col_dcDetail2.Close(); %>
        </tr>
        <% } %>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Case</td> 
            <%  SqlCommand rs_count3 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count3.CommandType = CommandType.StoredProcedure; rs_count3.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count3.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol3 = rs_count1.ExecuteReader(); int iCol3= 0; while (countCol3.Read()) { iCol3++; } countCol3.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol3 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc3 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc3.CommandType = CommandType.StoredProcedure;  rs_col_dc3.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc3.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc3 = rs_col_dc3.ExecuteReader(); while (col_dc3.Read()){ %>
                 <td style="text-align:center;"><%=col_dc3["DC_NO"].ToString() %></td> 
            <% } col_dc3.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail3 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail3.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail3.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail3.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail3 = rs_col_dcDetail3.ExecuteReader(); while (col_dcDetail3.Read()){ %>
                 <td style="text-align:right;">
                 <% 
                    SqlCommand rs_detail3 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail3.CommandType = CommandType.StoredProcedure;
                    rs_detail3.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail3.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail3.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail3["DC_NO"].ToString()) + "");
                    rs_detail3.Parameters.AddWithValue("@Data", "Case");
                    SqlDataReader obj_detail3 = rs_detail3.ExecuteReader();
                    if (obj_detail3.HasRows)
                    {
                        obj_detail3.Read();
                        Response.Write(Convert.ToDouble(obj_detail3["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail3.Close();
                    }
                 %>
                 </td>
            <% } col_dcDetail3.Close(); %>
        </tr>
        <% } %>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Load</td> 
            <%  SqlCommand rs_count4 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count4.CommandType = CommandType.StoredProcedure; rs_count4.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count4.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol4 = rs_count1.ExecuteReader(); int iCol4= 0; while (countCol4.Read()) { iCol4++; } countCol4.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol4 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc4 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc4.CommandType = CommandType.StoredProcedure;  rs_col_dc4.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc4.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc4 = rs_col_dc4.ExecuteReader(); while (col_dc4.Read()){ %>
                 <td style="text-align:center;"><%=col_dc4["DC_NO"].ToString() %></td> 
            <% } col_dc4.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail4 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail4.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail4.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail4.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail4 = rs_col_dcDetail4.ExecuteReader(); while (col_dcDetail4.Read()){ %>
                 <td style="text-align:right;">
                 <% 
                    SqlCommand rs_detail4 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail4.CommandType = CommandType.StoredProcedure;
                    rs_detail4.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail4.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail4.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail4["DC_NO"].ToString()) + "");
                    rs_detail4.Parameters.AddWithValue("@Data", "Load");
                    SqlDataReader obj_detail4 = rs_detail4.ExecuteReader();
                    if (obj_detail4.HasRows)
                    {
                        obj_detail4.Read();
                        Response.Write(Convert.ToDouble(obj_detail4["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail4.Close();
                    }
                 %>
                 </td> 
            <% } col_dcDetail4.Close(); %>
        </tr>
        <% } %>
        </table>

<% } %>
</body>
</html>
