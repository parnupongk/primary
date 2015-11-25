<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_sum.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.report_sum" %>
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
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Tesco Finance Report > Vendor Cost</b></td>
    </tr>
    <tr>
        <td aling="left" valign="middle"><b>Tesco Year-Week :</b> <%=Request.QueryString["YW"].ToString() %></td>
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
        <td aling="left" valign="middle"><b>DC Name : </b>
        <%
            if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { SqlCommand rs_cdName = new SqlCommand("select DC_Name from DC_Info where DC_NO='" + Request.QueryString["dc"].ToString() + "'", objConn); SqlDataReader obj_cdName = rs_cdName.ExecuteReader(); obj_cdName.Read(); Response.Write(obj_cdName["DC_Name"].ToString()); obj_cdName.Close(); } else { Response.Write("เลือกทั้งหมด"); }
        %>
        </td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Vendor Name</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Haulier</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">DC No</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Destination</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Currency</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Boxes</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Cases</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Pallets</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Trays</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Loads</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">RateType</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Revenue</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Revenue</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Margin</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Profit</td>
            </tr>
            <%  double total_a1 = 0.00, total_a2 = 0.00, total_a3 = 0.00, total_a4 = 0.00, total_a5 = 0.00, total_a6 = 0.00, total_a7 = 0.00, total_a8 = 0.00, total_a9 = 0.00; while (obj_detail.Read()){
                double a1 = obj_detail["Boxes"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Boxes"].ToString());
                double a2 = obj_detail["Pallets"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Pallets"].ToString());
                double a3 = obj_detail["Trays"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Trays"].ToString());
                double a4 = obj_detail["Loads"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Loads"].ToString());
                double a5 = obj_detail["Cases"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Cases"].ToString());
                double a6 = obj_detail["Cost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Cost"].ToString());
                double a7 = obj_detail["TotalCost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["TotalCost"].ToString());
                double a8 = obj_detail["Total_Revenue"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Total_Revenue"].ToString());
                double a9 = obj_detail["Profit"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail["Profit"].ToString());
                total_a1 = total_a1 + a1;
                total_a2 = total_a2 + a2;
                total_a3 = total_a3 + a3;
                total_a4 = total_a4 + a4;
                total_a5 = total_a5 + a5;
                total_a6 = total_a6 + a6;
                total_a7 = total_a7 + a7;
                total_a8 = total_a8 + a8;
                total_a9 = total_a9 + a9;
                double profit = 0.00;
                if (a7 <= 0) { profit = 0.00; } else { profit = (((a8 - a7) * 100) / a7); }
            %>
            <tr>
                <td align="left" valign="middle" ><%=obj_detail["Vendor_Name"].ToString() %></td>
                <td align="center" valign="middle" ><%=obj_detail["Haulier_Abbr"].ToString() %></td>
                <td align="center" valign="middle" ><%=obj_detail["DC_No"].ToString() %></td>
                <td align="left" valign="middle" ><%=obj_detail["Delivery_Location"].ToString() %></td>
                <td align="center" valign="middle" ><%=obj_detail["Currency"].ToString() %></td>
                <td align="right" valign="middle" ><%=obj_detail["Boxes"].ToString() %></td>
                <td align="right" valign="middle" ><%=obj_detail["Cases"].ToString() %></td>
                <td align="right" valign="middle" ><%=obj_detail["Pallets"].ToString() %></td>
                <td align="right" valign="middle" ><%=obj_detail["Trays"].ToString() %></td>
                <td align="right" valign="middle" ><%=obj_detail["Loads"].ToString() %></td>
                <td align="center" valign="middle" ><%=obj_detail["RateType"].ToString() %></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a6.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a7.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a8.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a8.ToString()).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a8-a7).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(profit.ToString()).ToString("#,##0.00") %></td>
            </tr>
    
            <% } obj_detail.Close(); %>
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;" colspan="6"></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=total_a1.ToString() %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=total_a5.ToString() %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=total_a2.ToString() %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=total_a3.ToString() %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=total_a4.ToString() %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a6.ToString()).ToString("#,##0.00") %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a7.ToString()).ToString("#,##0.00") %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a8.ToString()).ToString("#,##0.00") %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a8.ToString()).ToString("#,##0.00") %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(total_a8-total_a7).ToString("#,##0.00") %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"><%=Convert.ToDouble(((total_a8 - total_a7) * 100) / total_a7).ToString("#,##0.00") %></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</body>
</html>