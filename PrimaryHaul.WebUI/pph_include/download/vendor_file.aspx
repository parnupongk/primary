<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendor_file.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.vendor_file" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<!DOCTYPE html>
<%

    string sql_detail = "select top 1 * from Transportation where Year_Week_Upload='" + Request.QueryString["YW"].ToString() + "' and Vendor_Code='" + Request.QueryString["VD"].ToString() + "'";
    SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
    SqlDataReader obj_detail = rs_detail.ExecuteReader();
    obj_detail.Read();   
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<table cellpadding="5">
    <tr>
        <td colspan="16" align="right" valign="middle">&nbsp;</td>
        <td colspan="2" align="center" valign="middle" ><img src="http://www.proudprime.com/primaryhaul/pph_include/images/tesco_logo.jpg" /></td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle"><br /></td>
    </tr>
     <tr>
        <td colspan="16" align="right" valign="middle">&nbsp;</td>
        <td colspan="2" align="center" valign="middle"><b>Primary Distribution</b></td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle" style="background-color:#ff6a00;border:1px solid #000000;"><b>Supplier Invoice Backup Information</b></td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle"><b>SUMMARY DETAILS</b></td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle" style="border:1px solid #000000;">
        <table cellpadding="5">
            <tr>
                <td align="left" valign="middle" style="font-weight:bold;">Supplier Name :</td>
                <td align="left" valign="middle"><%=obj_detail["Vendor_Name"].ToString()%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Tesco Year :</td>
                <td align="left" valign="middle"><%=Request.QueryString["YW"].ToString().Substring(0,4)%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Cost (Exc Fuel) :</td>
                <td align="left" valign="middle"><%=obj_detail["Total_Cost_Charging"].ToString()%></td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle" style="font-weight:bold;" rowspan="3">Currency :</td>
                <td align="left" valign="middle" rowspan="3"><%=obj_detail["Currency"].ToString()%></td>
            </tr>
            <tr>
                <td align="left" valign="middle" style="font-weight:bold;">Supplier No :</td>
                <td align="left" valign="middle"><%=obj_detail["Vendor_Code"].ToString()%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Tesco Period :</td>
                <td align="left" valign="middle"><%=obj_detail["RC_Tesco_Period"].ToString()%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Fuel Cost :</td>
                <td align="left" valign="middle"><%=obj_detail["Sell_Fuel_Rate"].ToString()%></td>
                <td align="left" valign="middle"></td>
            </tr>
            <tr>
                <td align="left" valign="middle" style="font-weight:bold;">Oracle Supplier No :</td>
                <td align="left" valign="middle">0</td>
                <td align="left" valign="middle" style="font-weight:bold;">Date Sent :</td>
                <td align="left" valign="middle"><%=obj_detail["Sell_Fuel_Rate"].ToString()%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Total To Pay :</td>
                <td align="left" valign="middle"><%=obj_detail["Calc_Date"].ToString()%></td>
                <td align="left" valign="middle"></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle"><br /></td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle"><b>FUEL SURCHARGE DATA</b></td>
    </tr>
    <tr>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Tesco Period</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Agreed Fuel Base Price</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Agreed %</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">FTA Fuel Price</td>
        <td colspan="14" align="left" valign="middle">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["RC_Tesco_Period"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail["Sell_Fuel_Rate"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">0%</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">0.00</td>
        <td colspan="14" align="left" valign="middle">&nbsp;</td>
    </tr>
<% obj_detail.Close(); %>
    <tr>
        <td colspan="18" align="left" valign="middle"><br /></td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle"><b>DELIVERY DETAILS</b></td>
    </tr>
    <tr>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Tesco Week</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Delivery Date</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Haulier</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">PO Number</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Delivery Reference</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Collection Point</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Delivery Location</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Boxes</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Cases</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Loads</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Pallets</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Trays</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Tray/Box Rate Type</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Rate</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Cost</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Fuel Cost</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">VAT</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">Total Cost</td>
    </tr>
<%
    string sql_detail0 = "select *, case when RateType='Box' then No_Of_QTY end  as Boxes, " +
            "case when RateType='Pallet' then No_Of_QTY end  as Pallet, " +
            "case when RateType='Tray' then No_Of_QTY end  as Tray, " +
            "case when RateType='Load' then No_Of_QTY end  as Load from Transportation where Year_Week_Upload='" + Request.QueryString["YW"].ToString() + "' and Vendor_Code='" + Request.QueryString["VD"].ToString() + "' order by Vendor_Name asc";
    SqlCommand rs_detail0 = new SqlCommand(sql_detail0, objConn);
    SqlDataReader obj_detail0 = rs_detail0.ExecuteReader();
    double total_a1 = 0.00,total_a2 = 0.00,total_a3 = 0.00,total_a4 = 0.00;
    while (obj_detail0.Read()) {

        double a1 = obj_detail0["Boxes"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Boxes"].ToString());
        double a2 = obj_detail0["Pallet"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Pallet"].ToString());
        double a3 = obj_detail0["Tray"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Tray"].ToString());
        double a4 = obj_detail0["Load"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Load"].ToString());
        double a6 = obj_detail0["Sell_Fuel_Rate"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Sell_Fuel_Rate"].ToString());
        double a7 = obj_detail0["Total_Cost_Charging"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Total_Cost_Charging"].ToString());
        total_a1= total_a1+a1;
        total_a2= total_a2+(a7-((a7*7)/100));
        total_a3= total_a3+((a7*7)/100);
        total_a4= total_a4+(a7-((a7*7)/100))-((a7*7)/100);
%>
    <tr>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=Request.QueryString["YW"].ToString().Substring(0,4)%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Delivery_Date"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Haulier_Abbr"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["PO_No"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Delivery_Ref"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Collection_Point"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Delivery_Location"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Boxes"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">0</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Load"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Pallet"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Tray"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["RateType"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["RC_Sell_Rate"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=(a7-((a7*0)/100))-((a7*0)/100) %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=obj_detail0["Sell_Fuel_Rate"].ToString()%></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=((a7*0)/100) %></td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;"><%=a7%></td>
    </tr>
<%  } obj_detail0.Close();  %>
    <tr>
        <td colspan="18" align="left" valign="middle"><br /></td>
    </tr>
    <tr>
        <td align="center" valign="middle" colspan="6">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">TOTAL</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=total_a1 %></td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=total_a4 %></td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;"><%=total_a3 %></td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-top:1px solid #000000;border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;"><%=total_a2 %></td>
    </tr>
</table>
</body>
</html>

