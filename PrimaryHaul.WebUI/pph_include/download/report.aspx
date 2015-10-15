<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<table cellpadding="5" border="0">
    <tr>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Supplier No</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Supplier Name</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Haulier</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">DC No</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Destination</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Currency</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Boxes</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Cases</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Pallets</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Trays</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Loads</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Cost</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Total Cost</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Revenue</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Total Revenue</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Profit</td>
    </tr>
    <%  double total_a1 = 0.00, total_a2 = 0.00, total_a3 = 0.00, total_a4 = 0.00, total_a5 = 0.00, total_a6 = 0.00, total_a7 = 0.00, total_a8 = 0.00; while (obj_detail.Read()){
        double a1 = obj_detail["Boxes"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Boxes"].ToString());
        double a2 = obj_detail["Pallet"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Pallet"].ToString());
        double a3 = obj_detail["Tray"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Tray"].ToString());
        double a4 = obj_detail["Load"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Load"].ToString());
        double a5 = obj_detail["Cost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Cost"].ToString());
        double a6 = obj_detail["TotalCost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["TotalCost"].ToString());
        double a7 = obj_detail["Total_Revenue"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Revenue"].ToString());
        double a8 = obj_detail["Profit"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Profit"].ToString());
        total_a1 = total_a1 + a1;
        total_a2 = total_a2 + a2;
        total_a3 = total_a3 + a3;
        total_a4 = total_a4 + a4;
        total_a5 = total_a5 + a5;
        total_a6 = total_a6 + a6;
        total_a7 = total_a7 + a7;
        total_a8 = total_a8 + a8;
    %>
    <tr>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Vendor_Code"].ToString() %></td>
        <td align="left" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Vendor_Name"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Haulier_Abbr"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["DC_No"].ToString() %></td>
        <td align="left" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Delivery_Location"].ToString() %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Currency"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Boxes"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Pallet"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Tray"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Load"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Cost"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["TotalCost"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Total_Revenue"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Total_Revenue"].ToString() %></td>
        <td align="right" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;"><%=obj_detail["Profit"].ToString() %></td>
    </tr>
    
    <% } obj_detail.Close(); %>
    <tr>
        <td colspan="11"><br /></td>
    </tr>
    <tr>
        <td colspan="6"><</td>
        <td align="right" valign="middle"><b><%=total_a1 %></b></td>
        <td ></td>
        <td align="right" valign="middle"><b><%=total_a2 %></b></td>
        <td align="right" valign="middle"><b><%=total_a3 %></b></td>
        <td align="right" valign="middle"><b><%=total_a4 %></b></td>
        <td align="right" valign="middle"><b><%=total_a5 %></b></td>
        <td align="right" valign="middle"><b><%=total_a6 %></b></td>
        <td align="right" valign="middle"><b><%=total_a7 %></b></td>
        <td align="right" valign="middle"><b><%=total_a7 %></b></td>
        <td align="right" valign="middle"><b><%=total_a8 %></b></td>
    </tr>
    <tr>
        <td colspan="11"><br /><br /><br /></td>
    </tr>
</table>
</body>
</html>
