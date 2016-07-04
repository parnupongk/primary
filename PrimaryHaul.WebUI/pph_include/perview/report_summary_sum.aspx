<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_summary_sum.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.perview.report_summary_sum" %>

<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<table cellpadding="2" width="1000px" align="center">
    <tr>
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Tesco Finance Report > Revenue Profit</b></td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Tesco Year-Week :</b> <%=Request.QueryString["YW"].ToString() %> to <%=Request.QueryString["ywend"].ToString() %></td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Haulier Name :</b>
        <%
            if (!string.IsNullOrEmpty(Request.QueryString["hl"] as string)) { SqlCommand rs_hlName = new SqlCommand("select Haulier_Name_En from Haulier_Info where Haulier_Abbr='" + Request.QueryString["hl"].ToString() + "'", objConn); SqlDataReader obj_hlName = rs_hlName.ExecuteReader(); obj_hlName.Read(); Response.Write(obj_hlName["Haulier_Name_En"].ToString()); obj_hlName.Close(); } else { Response.Write("เลือกทั้งหมด"); }
        %>

        </td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Vendor Name : </b>
        <%
            if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)) { SqlCommand rs_vdName = new SqlCommand("select Vendor_Name_En from Vendor_Info where VendorID='" + Request.QueryString["vd"].ToString() + "'", objConn); SqlDataReader obj_vdName = rs_vdName.ExecuteReader(); obj_vdName.Read(); Response.Write(obj_vdName["Vendor_Name_En"].ToString()); obj_vdName.Close(); } else { Response.Write("เลือกทั้งหมด"); }
        %>
        </td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Tesco Year</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Period</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Tesco Week No</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Vendor Code</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Vendor Name</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DC No</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Accrued Revenue</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Revenue</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Accrued Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Margin</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Profit  %</td>
            </tr>
            <% double total_a2 = 0.00, total_a3 = 0.00; while (obj_detail.Read()){
                   double a1 = obj_detail["Accrued_Revenue"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Accrued_Revenue"].ToString());
                   double a2 = obj_detail["Total_Revenue"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Revenue"].ToString());
                   double a3 = obj_detail["Total_Cost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Cost"].ToString());
                   total_a2 = total_a2 + a2;
                   total_a3 = total_a3 + a3;
                   double profit =0.00;
                   if (a3 <= 0) { profit = 0.00; } else { profit = (((a2 - a3) * 100) / a3); }
        %>
            <tr>
                <td align="center" valign="middle"><%=obj_detail["Year"].ToString() %></td>
                <td align="center" valign="middle"><%=obj_detail["rc_tesco_period"].ToString() %></td>
                <td align="center" valign="middle"><%=obj_detail["Week"].ToString() %></td>
                <td align="center" valign="middle"></td>
                <td align="left" valign="middle"><%=obj_detail["Vendor_Name"].ToString() %></td>
                <td align="center" valign="middle"><%=obj_detail["DC_No"].ToString() %></td>
                <td align="right" valign="middle"><%=Convert.ToDouble(a1.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle"><%=Convert.ToDouble(a2.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle"><%=Convert.ToDouble(a3.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle"><%=Convert.ToDouble(a3.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle"><%=Convert.ToDouble(a2-a3).ToString("#,##0.00") %></td>
                <td align="right" valign="middle"><%=Convert.ToDouble(profit.ToString()).ToString("#,##0.00") %></td>
            </tr>
    
            <% } obj_detail.Close(); double profit_total = 0.00; if (total_a3 <= 0) { profit_total = 0.00; } else { profit_total = (((total_a2 - total_a3) * 100) / total_a3); } %>
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;" colspan="7"></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a2.ToString()).ToString("#,##0.00") %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a3.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a2-total_a3).ToString("#,##0.00") %></td>                
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(profit_total).ToString("#,##0.00") %></td>
            </tr>
        </table>
        </td>
    </tr>
</table>

</body>
</html>