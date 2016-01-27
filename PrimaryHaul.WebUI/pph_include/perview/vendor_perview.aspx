<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendor_perview.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.perview.vendor_perview" %>

<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<!DOCTYPE html>
<%

    string sql_detail = "select top 1 Vendor_Name,Vendor_Code,RC_Tesco_Period,ISNULL(Sell_Fuel_Rate, 0.00) as Sell_Fuel_Rate,Currency, ISNULL(sum(Sell_Fuel_Rate),0.00) as costFuel, ISNULL(sum(Total_Cost_Charging),0.00) as costTotal,  (select Top 1 CONVERT(varchar(11),Download_DateTime,103)  from Vendor_Download_Log where Tesco_Year_Week='" + Request.QueryString["YW"].ToString() + "' and Vendor_UserID=" + Request.QueryString["id"] + " and substring(File_Name,1,5)='" + Request.QueryString["VD"].ToString() + "' order by Download_DateTime desc) as lastDownload, ISNULL(sum(Sell_Fuel_Rate),0.00) as fRate from Transportation  where Year_Week_Upload='" + Request.QueryString["YW"].ToString() + "' and Vendor_Code='" + Request.QueryString["VD"].ToString() + "' and Calc_Date is not null GROUP BY Vendor_Name,Vendor_Code,RC_Tesco_Period,Sell_Fuel_Rate,Currency,year_week_upload";
    SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
    SqlDataReader obj_detail = rs_detail.ExecuteReader();
    obj_detail.Read();   
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<table cellpadding="5" width="1200px;" align="center">
    <tr>
        <td align="right" valign="middle">&nbsp;</td>
        <td align="right" valign="middle" ><img src="http://www.proudprime.com/primaryhaul/pph_include/images/tesco_logo.jpg" width="144" /></td>
    </tr>
     <tr>
        <td align="right" valign="middle">&nbsp;</td>
        <td align="right" valign="middle"><b>Primary Distribution</b></td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Vendor Invoice Backup Information</b></td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle"><b>DELIVERY SUMMARY</b></td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle" style="border:2px solid #000000;">
        <table cellpadding="5" style="width:100%;">
            <tr>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;" width="15%">Vendor Name :</td>
                <td align="left" valign="middle" width="85%" style="font-size:11pt;" colspan="5"><%=obj_detail["Vendor_Name"].ToString()%></td>
            </tr>
            <tr>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;" width="15%">Tesco Year :</td>
                <td align="left" valign="middle" width="17%" style="font-size:11pt;"><%=Request.QueryString["YW"].ToString().Substring(0,4)%></td>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;" width="17%">Cost (Exc Fuel) :</td>
                <td align="left" valign="middle" width="17%" style="font-size:11pt;"><%=obj_detail["Currency"].ToString()%> <%= Convert.ToDouble(obj_detail["costFuel"].ToString()).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;" width="17%">Currency :</td>
                <td align="left" valign="middle" width="17%" style="font-size:11pt;"><%=obj_detail["Currency"].ToString()%></td>
            </tr>
            <tr>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;">Vendor No :</td>
                <td align="left" valign="middle" style="font-size:11pt;"><%=obj_detail["Vendor_Code"].ToString()%></td>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;">Tesco Period :</td>
                <td align="left" valign="middle" style="font-size:11pt;"><%=obj_detail["RC_Tesco_Period"].ToString()%></td>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;">Fuel Cost :</td>
                <td align="left" valign="middle" style="font-size:11pt;"><%=obj_detail["Currency"].ToString()%> <%= Convert.ToDouble(obj_detail["Sell_Fuel_Rate"].ToString()).ToString("#,##0.00")%></td>
            </tr>
            <tr>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;">Oracle Vendor No :</td>
                <td align="left" valign="middle" style="font-size:11pt;">0</td>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;">Date Download :</td>
                <td align="left" valign="middle" style="font-size:11pt;"><%=obj_detail["lastDownload"].ToString()%></td>
                <td align="right" valign="middle" style="font-weight:bold;font-size:11pt;">Total To Pay :</td>
                <td align="left" valign="middle" style="font-size:11pt;"><%=obj_detail["Currency"].ToString()%> <%= Convert.ToDouble(obj_detail["costTotal"].ToString()).ToString("#,##0.00")%></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle"><br /></td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle"><b>FUEL SURCHARGE DATA</b></td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle">
        <table cellpadding="5" border="1" bordercolor="#000000" cellspacing="0">
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;"">Tesco Period</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Agreed Fuel Base Price</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Agreed %</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">FTA Fuel Price</td>
            </tr>
            <tr>
                <td align="center" valign="middle" ><%=obj_detail["RC_Tesco_Period"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail["Sell_Fuel_Rate"].ToString()%></td>
                <td align="center" valign="middle" >0%</td>
                <td align="center" valign="middle" >0.00</td>
            </tr>
        </table>
        </td>
    </tr>
<% obj_detail.Close(); %>
<% 
    string sql_cpoint = "select Distinct Collection_Point from Transportation where Year_Week_Upload='" + Request.QueryString["YW"].ToString() + "' and Vendor_Code='" + Request.QueryString["VD"].ToString() + "' and Calc_Date is not null";
    SqlCommand rs_cpoint = new SqlCommand(sql_cpoint, objConn);
    SqlDataReader obj_cpoint = rs_cpoint.ExecuteReader();
    while (obj_cpoint.Read()) {
%>
    <tr>
        <td colspan="2" align="left" valign="middle"><br /></td>
    </tr>

    <tr>
        <td colspan="2" align="left" valign="middle">
        <table cellpadding="5" border="1" bordercolor="#000000" cellspacing="0">
            <tr>
                <td colspan="17" align="left" valign="middle" style="background-color:#00ffff;font-weight:bold;">DELIVERY DETAILS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=obj_cpoint["Collection_Point"].ToString()%></td>
            </tr>    
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Tesco Week</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Delivery Date</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Haulier</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">PO Number</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Delivery Reference</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Delivery Location</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Boxes</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Cases</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Loads</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Pallets</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Trays</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Tray/Box Rate Type</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Rate</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Fuel Cost</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">VAT</td>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;">Total Cost</td>
            </tr>
         <%
        string sql_detail0 = "Select Year_Week_Upload,Delivery_Date,Haulier_Abbr,PO_No,Delivery_Ref,Delivery_Location,TransID, " +
            "case when upper(RateType) like '%Box%' then No_Of_QTY end  as Boxes, " +
            "case when upper(RateType) like '%Pallet%' then No_Of_QTY end  as Pallets,  " +
            "case when upper(RateType) like '%Tray%' then No_Of_QTY end  as Trays, " +
            "case when upper(RateType) like '%Cases%' then No_Of_QTY end  as Cases,  " +
            "case when upper(RateType) like '%Load%' then No_Of_QTY end  as Loads,  " +
            "RateType , rc_sell_rate,Sell_Fuel_Rate,  " +
            "CAST((Total_Cost_Charging*Vat_Default) AS Decimal(6,2)) As Vat_Cost, " +
            "Total_Cost_Charging " +
            "from Transportation  " +
            "where Year_Week_Upload='" + Request.QueryString["YW"].ToString() + "' and Vendor_Code='" + Request.QueryString["VD"].ToString() + "'  " +
            "and replace(collection_point,' ','')=replace('" + obj_cpoint["Collection_Point"].ToString() + "',' ','') " +
            "Order by TransID";
            SqlCommand rs_detail0 = new SqlCommand(sql_detail0, objConn);
            SqlDataReader obj_detail0 = rs_detail0.ExecuteReader();
            double total_a1 = 0.00, total_a2 = 0.00, total_a3 = 0.00, total_a4 = 0.00, total_a5 = 0.00, total_a6 = 0.00, total_a7 = 0.00, total_vat = 0.00;
            while (obj_detail0.Read()) {

                double a1 = obj_detail0["Boxes"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Boxes"].ToString());
                double a2 = obj_detail0["Pallets"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Pallets"].ToString());
                double a3 = obj_detail0["Trays"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Trays"].ToString());
                double a4 = obj_detail0["Loads"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Loads"].ToString());
                double a5 = obj_detail0["Cases"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Cases"].ToString());
                double vat = obj_detail0["Vat_Cost"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Vat_Cost"].ToString());
                double a7 = obj_detail0["Total_Cost_Charging"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Total_Cost_Charging"].ToString());
                double a8 = obj_detail0["Sell_Fuel_Rate"].ToString().Trim() == "" ? 0 : double.Parse(obj_detail0["Sell_Fuel_Rate"].ToString());
                total_a1 = total_a1 + a1;
                total_a2 = total_a2 + a2;
                total_a3 = total_a3 + a3;
                total_a4 = total_a4 + a4;
                total_a5 = total_a5 + a5;
                total_vat = total_vat + vat;
                total_a7 = total_a7 + a7;
                
        %>
            <tr>
                <td align="center" valign="middle" ><%=Request.QueryString["YW"].ToString().Substring(4,2)%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Delivery_Date"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Haulier_Abbr"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["PO_No"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Delivery_Ref"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Delivery_Location"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Boxes"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Cases"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Loads"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Pallets"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["Trays"].ToString()%></td>
                <td align="center" valign="middle" ><%=obj_detail0["RateType"].ToString()%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(obj_detail0["RC_Sell_Rate"].ToString()).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble((a7-vat)).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(obj_detail0["Sell_Fuel_Rate"].ToString()).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(obj_detail0["Vat_Cost"].ToString()).ToString("#,##0.00")%></td>
                <td align="right" valign="middle" ><%=Convert.ToDouble(a7.ToString()).ToString("#,##0.00")%></td>
            </tr>
        <%  } obj_detail0.Close();  %>
            <tr>
                <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;" colspan="6">TOTAL</td>
                <td align="center" valign="middle" style="background-color:#00ffff;"><%=total_a1 %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;"><%=total_a5 %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;"><%=total_a4 %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;"><%=total_a2 %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;"><%=total_a3 %></td>
                <td align="center" valign="middle" style="background-color:#00ffff;"></td>
                <td align="right" valign="middle" style="background-color:#00ffff;"></td>
                <td align="right" valign="middle" style="background-color:#00ffff;"><%=Convert.ToDouble(total_a7-total_vat).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" style="background-color:#00ffff;">0.00</td>
                <td align="right" valign="middle" style="background-color:#00ffff;"><%=Convert.ToDouble(total_vat).ToString("#,##0.00") %></td>
                <td align="right" valign="middle" style="background-color:#00ffff;"><%=Convert.ToDouble(total_a7).ToString("#,##0.00") %></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="left" valign="middle"><br /></td>
    </tr>
 <%  } obj_cpoint.Close();  %>
</table>
</body>
</html>

