<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_kpi.aspx.cs" Inherits="PrimaryHaul.WebUI.report_kpi" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<% string strWeek = "";if (!string.IsNullOrEmpty(Request.QueryString["week"] as string)) { strWeek = Request.QueryString["week"].ToString(); } %>
<script>
    function js_Wselect(varUrl, varWeek) {
        window.location.href = document.getElementById(varUrl).value + '&week=' + document.getElementById(varWeek).value;
    }
</script>
<div class="form-horizontal">
    <div class="row">
        <div class="col-md-12"><h4>KPI Report</h4><hr /></div>
    </div>
    <div class="row">
        <div class="col-md-12">  
            <div class="row">
                <div class="col-md-1"><label class="control-label">Week : </label></div>
                <div class="col-md-3" style="text-align:left;">
                    <select class="form-control" style="width:100%;" id="week" name="week">
                        <%
                            SqlDataReader obj_ywALL = PPH_SC.PPH_MAIN.get_ywAll(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
                            if (obj_ywALL.HasRows) {
                            while (obj_ywALL.Read()){
                        %>
                        <option value="<%= obj_ywALL["dateweek"].ToString() %>" <% if (strWeek == obj_ywALL["dateweek"].ToString()) { Response.Write("selected"); } %>><%= obj_ywALL["dateweek"].ToString() %></option>
                        <% } obj_ywALL.Close(); } %>
                    </select>
                </div>
                <div class="col-md-8" style="text-align:left;"><input type="button" value="Search" class="btn btn-default" onclick="js_Wselect('urlSubmit', 'week');" /></div>
            </div>
        </div>
    </div>
    
    <% if (!string.IsNullOrEmpty(Request.QueryString["week"] as string)){%>
    <input type="hidden" name="hidWeek" id="hidWeek" runat="server" />
    <div class="row">
        <div class="col-md-12">&nbsp;</div>
    </div> 
    <div class="row">
        <div class="col-md-12">  
            <div class="row">
                <div class="col-md-2"><input type="button" value="Export To Excel" class="btn btn-default"  /></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">&nbsp;</div>
    </div> 
     <div class="row">
        <div class="col-md-12">
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
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_kpi["Load_Appt"].ToString() %></td>
            </tr>
            <% } obj_kpi.Close();} %>
            </table>
        </div>
    </div>
    <% } %>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
