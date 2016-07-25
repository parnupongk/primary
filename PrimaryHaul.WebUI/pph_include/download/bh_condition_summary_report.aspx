<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bh_condition_summary_report.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.bh_condition_summary_report" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<%
    Response.AddHeader("Content-Disposition", "attachment;filename=Condition_Summary_Report.xls");
    Response.Buffer = true;
    Response.Charset = "UTF-8";
    Response.ContentType = "application/vnd.ms-excel"; 
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title></title>
</head>
<body>
<table cellpadding="2" width="1000px" align="center">
    <tr>
        <td align="left" valign="middle" style="background-color:#019a7b;border:2px solid #000000;"><b>Backhaul Charge by Vendor > Summary Report</b></td>
    </tr>
    <tr>
        <td>
        <table cellpadding="5"  align="center" border="1" bordercolor="#000000" cellspacing="0" width="100%">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;">Vendor Code</td>
                <td style="text-align:center;">Vendor Name (by location)</td>
                <td style="text-align:center;">DC</td>
                <td style="text-align:center;">Sum of Load (RCVD)</td>
                <td style="text-align:center;">Sum of Case RCVD</td>
                <td style="text-align:center;">Sum of BHA</td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0, icolor = 0, intSumLoad = 0, intSumCase = 0;
                decimal totalBHA = 0;
                string[] adStart = Request.QueryString["adStart"].ToString().Split('/');
                string[] adEnd = Request.QueryString["adEnd"].ToString().Split('/');
                SqlCommand cmd = new SqlCommand("usp_BH_Charge_by_Vendor_Summary", objConn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ApptDate_Start", "" + adStart[2] + "-" + adStart[1] + "-" + adStart[0] + "");
                cmd.Parameters.AddWithValue("@ApptDate_End", "" + adEnd[2] + "-" + adEnd[1] + "-" + adEnd[0] + "");
                cmd.Parameters.AddWithValue("@Vendor_Name", Request.QueryString["adVD"].ToString());
                SqlDataReader obj_result = cmd.ExecuteReader();
                if (obj_result.HasRows){
                    while (obj_result.Read()){
                        irows++;icolor++;
                        if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
                        if (obj_result["Sum_Load_RCVD"].ToString() != "") { intSumLoad = intSumLoad + Convert.ToInt32(obj_result["Sum_Load_RCVD"].ToString()); }
                        if (obj_result["Sum_RAMS_Case_RCVD"].ToString() != "") { intSumCase = intSumCase + Convert.ToInt32(obj_result["Sum_RAMS_Case_RCVD"].ToString()); }
                        if (obj_result["Sum_RAMS_Case_Baht"].ToString() != "") { totalBHA = totalBHA + Convert.ToDecimal(obj_result["Sum_RAMS_Case_Baht"].ToString()); }
            %>
            <tr <%= detailColor %>>
                <td style="text-align:center;"><%= obj_result["vendor_code"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["vendor_name"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["dc_no"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["Sum_Load_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["Sum_RAMS_Case_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["Sum_RAMS_Case_Baht"].ToString() %></td>
            </tr>
            <% } obj_result.Close();} %>
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;" colspan="3"></td>
                <td style="text-align:center;"><%= intSumLoad %></td>
                <td style="text-align:center;"><%= intSumCase %></td>
                <td style="text-align:center;"><%= totalBHA %></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</body>
</html>