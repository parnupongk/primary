<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendor_download_log.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.vendor_download_log" %>
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
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Tesco Finance Report > Vendor Downlaod Log</b></td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Tesco Year-Week :</b> <%=Request.QueryString["YW"].ToString() %></td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">No</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Vendor</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Download Time</td>
            </tr>
            <% int irows = 0;  while (obj_detail.Read())
               {
                   irows++;
            %>
            <tr>
                <td align="center" valign="middle" ><%=irows%></td>
                <td align="left" valign="middle" ><%=obj_detail["Vendor_Code"].ToString()%></td>
                <td align="left" valign="middle" ><%=obj_detail["Download_DateTime"].ToString()%></td>
            </tr>
    
            <% } obj_detail.Close(); %>
        </table>
        </td>
    </tr>
</table>
</body>
</html>
