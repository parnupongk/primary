<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendor_file.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.vendor_file" %>

<!DOCTYPE html>

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
                <td align="left" valign="middle"><%=obj_detail[0].ToString()%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Tesco Year :</td>
                <td align="left" valign="middle"><%=Request.QueryString["YW"].ToString().Substring(0,4)%></td>
                <td align="left" valign="middle" style="font-weight:bold;">Cost (Exc Fuel) :</td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle" style="font-weight:bold;" rowspan="3">Currency :</td>
                <td align="left" valign="middle" rowspan="3"></td>
            </tr>
            <tr>
                <td align="left" valign="middle" style="font-weight:bold;">Supplier No :</td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle" style="font-weight:bold;">Tesco Period :</td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle" style="font-weight:bold;">Fuel Cost :</td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle"></td>
            </tr>
            <tr>
                <td align="left" valign="middle" style="font-weight:bold;">Oracle Supplier No :</td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle" style="font-weight:bold;">Date Sent :</td>
                <td align="left" valign="middle"></td>
                <td align="left" valign="middle" style="font-weight:bold;">Total To Pay :</td>
                <td align="left" valign="middle"></td>
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
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">&nbsp;</td>
        <td colspan="14" align="left" valign="middle">&nbsp;</td>
    </tr>
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
    <tr>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="18" align="left" valign="middle"><br /></td>
    </tr>
    <tr>
        <td align="center" valign="middle" colspan="6">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">Query Summary</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" valign="middle" colspan="6">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;font-weight:bold;border-left:1px solid #000000;border-bottom:1px solid #000000;">TOTAL</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;">&nbsp;</td>
        <td align="center" valign="middle" style="background-color:#00ffff;border-left:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">&nbsp;</td>
    </tr>
</table>
</body>
</html>
