<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hualier_cost.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.perview.hualier_cost" %>
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
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Tesco Finance Report > Hualier Cost</b></td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Tesco Year-Week :</b> <%=Request.QueryString["YW"].ToString() %> to <%=Request.QueryString["ywend"].ToString() %></td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">No</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Haulier</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DC No</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Revenue</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Profit</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">% Profit</td>
            </tr>
            <%  int irows = 0; double total_a1 = 0.00, total_a2 = 0.00, total_a3 = 0.00; if (obj_detail.HasRows)
                {
                    while (obj_detail.Read())
                    {
                        irows++;
                        double a1 = obj_detail["Total_Revenue"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Revenue"].ToString());
                        double a2 = obj_detail["Total_Cost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Cost"].ToString());
                        double a3 = obj_detail["Percent_Profit"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Percent_Profit"].ToString());
                        total_a1 = total_a1 + a1;
                        total_a2 = total_a2 + a2;
                        total_a3 = total_a3 + a3;
            %>
            <tr>
                <td align="center" valign="middle" ><%=irows%></td>
                <td align="left" valign="middle" ><%=obj_detail["Haulier_Abbr"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["DC_No"].ToString()%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(obj_detail["Total_Revenue"].ToString()).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(obj_detail["Total_Cost"].ToString()).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble((a1 - a2)).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a3).ToString("#,##0.00")%></td>
            </tr>
    
            <% } obj_detail.Close();
                } %>
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;" colspan="3"></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a1.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a2.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble((total_a1-total_a2)).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a3.ToString()).ToString("#,##0.00") %></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</body>
</html>