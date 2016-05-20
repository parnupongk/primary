<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_kpi.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.report_kpi" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
</head>
<body>
<table class="table table-bordered">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;">RATE</td>
                <td style="text-align:center;">Unload cost</td>
                <td style="text-align:center;">Wk (RCVD)</td>
                <td style="text-align:center;">Period (RCVD)</td>
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
                <td style="text-align:center;">Unloading (BHA)</td>
                <td style="text-align:center;">Type income</td>
                <td style="text-align:center;">Remark</td>
                <td style="text-align:center;">Flag</td>
                <td style="text-align:center;">System Income</td>
                <td style="text-align:center;">Reimbursement</td>
                <td style="text-align:center;">Appt. No</td>
                <td style="text-align:center;">Appt. Case</td>
            </tr>
            <%
           string detailColor = "";
                int irows = 0, icolor = 0;
                SqlDataReader obj_kpi = PPH_SC.PPH_BH.get_kpi_report(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], Request.QueryString["week"].ToString());
                if (obj_kpi.HasRows){
                    while (obj_kpi.Read()){
                        irows++;icolor++;
                        if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
            %>
            <tr <%= detailColor %>>
                <td style="text-align:center;"><%= obj_kpi["RateCard_Rate"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["RateCard_Unloading_Cost"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Week"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Period"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Vendor_Code"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Week"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Period"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Vendor_Name"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Appt_Date"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["PO_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["DC_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Case_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["BHA"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Uploading_BHA"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["RateCard_Income_Type"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["RateCard_Remark"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["RateCard_ChargeType"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["System_Income"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Reimbursement"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Appt_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Appt_Case"].ToString() %></td>
            </tr>
            <% } obj_kpi.Close();} %>
            </table>
</body>
</html>
