<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_summary.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.perview.report_summary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<table cellpadding="5" border="0">
    <tr>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Tesco Year</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Period</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Tesco Week No</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Supplier Group No</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Supplier Name</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Haulier</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Accrued Revenue</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Total Revenue</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Accrued Cost</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Total Cost</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">Total Profit  %</td>
    </tr>
    <% double total_a1 = 0.00, total_a2 = 0.00; while (obj_detail.Read()){
    double a1 = obj_detail["Total_Revenue"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Revenue"].ToString());
    double a2 = obj_detail["Total_Cost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Cost"].ToString());
    total_a1 = total_a1 + a1;
    total_a2 = total_a2 + a2;
%>
    <tr>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Year"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["rc_tesco_period"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Week"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Vendor_Code"].ToString() %></td>
        <td align="left" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Vendor_Name"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Haulier_Abbr"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Accrued_Revenue"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Total_Revenue"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Accrued_Cost"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Total_Cost"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;"></td>
    </tr>
    
    <% } obj_detail.Close(); %>
    <tr>
        <td colspan="11"><br /></td>
    </tr>
    <tr>
        <td colspan="7"><</td>
        <td align="right" valign="middle"><b><%=total_a1 %></b></td>
        <td ></td>
        <td align="right" valign="middle"><b><%=total_a2 %></b></td>
        <td ></b></td>
    </tr>
    <tr>
        <td colspan="11"><br /><br /><br /></td>
    </tr>
</table>
</body>
</html>
