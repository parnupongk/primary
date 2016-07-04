<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="backhaul_transaction.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.backhaul_transaction" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title></title>
</head>
<body>
<table cellpadding="2" width="1000px" align="center">
    <tr>
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Tesco Finance Report > Export File Primary Transaction</b></td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Tesco Year-Week :</b> <%=Request.QueryString["YW"].ToString() %></td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">WEEK</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">PERIOD</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">VEND NAME</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DATE</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">NO.OF LOAD</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">LOAD COUNT</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">PO NBR</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DC</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">LOAD NO.</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">APPT. TO DC</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">TYPE</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">APPTNBR</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">PALET</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">REMARK</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Pallet From Vendor</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Pallet From Vendor</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Rate</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Rate Unloading</td>
            </tr>
            <% int irows = 0;  while (obj_detail.Read()){irows++;%>
            <tr>
                <td align="center" valign="middle" ><%=obj_detail["Week"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Period"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Vendor_Name"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Appt_Date"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Load_Appt"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Load_Rcvd"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["PO_No"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["DC_No"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Load_No"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Appt_To_DC"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Type"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["APPTNBR"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Case_Appt"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Pallet"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Remark"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Pallet_From_Vendor"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Total_Pallet_From_Vendor"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Rate"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Rate_Unloading"].ToString()%></td>
            </tr>
            <% } obj_detail.Close(); %>
        </table>
        </td>
    </tr>
</table>
</body>
</html>
