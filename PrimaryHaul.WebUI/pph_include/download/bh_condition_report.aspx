<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bh_condition_report.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.bh_condition_report" %>
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
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Backhaul charge by Vendor > Condition Report</b></td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;">Vendor Code</td>
                <td style="text-align:center;">Wk (appt)</td>
                <td style="text-align:center;">Period (appt)</td>
                <td style="text-align:center;">Vendor Name (by location)</td>
                <td style="text-align:center;">Appt Date</td>
                <td style="text-align:center;">Load (appt)</td>
                <td style="text-align:center;">Load (RCVD)</td>
                <td style="text-align:center;">PO</td>
                <td style="text-align:center;">DC</td>
                <td style="text-align:center;">Case RCVD</td>
                <td style="text-align:center;">BHA</td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0, icolor = 0;
                string[] adStartD = Request.QueryString["adStart"].ToString().Split('/');
                string[] adEndD = Request.QueryString["adEnd"].ToString().Split('/');
                SqlCommand cmdD = new SqlCommand("usp_BH_Charge_by_Vendor_Details", objConn);
                cmdD.CommandType = CommandType.StoredProcedure;
                cmdD.Parameters.AddWithValue("@ApptDate_Start", "" + adStartD[2] + "-" + adStartD[1] + "-" + adStartD[0] + "");
                cmdD.Parameters.AddWithValue("@ApptDate_End", "" + adEndD[2] + "-" + adEndD[1] + "-" + adEndD[0] + "");
                cmdD.Parameters.AddWithValue("@Vendor_Name", Request.QueryString["adVD"].ToString());
                SqlDataReader obj_resultD = cmdD.ExecuteReader();
                if (obj_resultD.HasRows){
                    while (obj_resultD.Read()){
                        irows++;icolor++;
                        if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
            %>
            <tr <%= detailColor %>>
                <td style="text-align:center;"><%= obj_resultD["vendor_code"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Wk_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Period_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["vendor_name"].ToString() %></td>
                <td style="text-align:center;"><%= Convert.ToDateTime(obj_resultD["Appt_Date"].ToString()).ToString("dd/MM/yyyy") %></td>
                <td style="text-align:center;"><%= obj_resultD["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Load_Rcvd"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Po_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["DC_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["RAMS_Case_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["RAMS_Case_Baht"].ToString() %></td>
            </tr>
            <% } obj_resultD.Close();} %>
        </table>
        </td>
    </tr>
</table>
</body>
</html>