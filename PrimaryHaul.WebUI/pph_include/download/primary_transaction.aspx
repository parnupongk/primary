<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="primary_transaction.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.primary_transaction" %>
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
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">HAULIER</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">PO NUMBER</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DELIVERY REF</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DELIVERY DATE</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">SUPPLIER NUMBER</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">SUPPLIER NAME</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">COLLECTION POINT</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DELIVERY LOCATION</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Tray/Box Rate Type (Unit)</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Number of Quantity</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Rate per Unit</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">CURRENCY</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Additional Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Additional Cost Reason</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">TOTAL COST</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">BACKHAUL YEAR WEEK NO</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Remark1</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Remark2</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Applied Fuel Price (THB/Litre)</td>
            </tr>
            <% int irows = 0;  while (obj_detail.Read()){irows++;%>
            <tr>
                <td align="center" valign="middle" ><%=obj_detail["Haulier_Abbr"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["PO_No"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Delivery_Ref"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Delivery_Date"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Vendor_Code"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Vendor_Name"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Collection_Point"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Delivery_Location"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["RateType"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["No_Of_Qty"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Rate_Per_Unit"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Currency"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Additional_Cost"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Additional_Cost_Reason"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Total_Cost"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Year_Week_Upload"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Remark1"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Remark2"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Fuel_Rate"].ToString()%></td>
            </tr>
            <% } obj_detail.Close(); %>
        </table>
        </td>
    </tr>
</table>
</body>
</html>
