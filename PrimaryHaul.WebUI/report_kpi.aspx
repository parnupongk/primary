<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_kpi.aspx.cs" Inherits="PrimaryHaul.WebUI.report_kpi" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
 <% string strWeek = "";if (!string.IsNullOrEmpty(Request.QueryString["week"] as string)) { strWeek = Request.QueryString["week"].ToString(); } %>
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
                <div class="col-md-8" style="text-align:left;"><input type="button" value="Search" class="btn btn-default" /></div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
