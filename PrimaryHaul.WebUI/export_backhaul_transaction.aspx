<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="export_backhaul_transaction.aspx.cs" Inherits="PrimaryHaul.WebUI.export_backhaul_transaction" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_export(yw, type) {
        var objyw = '';
        objyw = document.getElementById(yw).value;
        objyw = document.getElementById(yw).value;
        if (objyw == "") {
            alert('กรุณาเลือก Year-Week');
            return false;
        }else{
            window.open('./pph_include/download/backhaul_transaction.aspx?yw=' + objyw, '_blank');
        }
    }
</script>
<div id="form_view01">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Backhaul > Export File Backhaul Transaction</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_Export" name="YW_Export">
                 <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_export = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_export = rs_yw_export.ExecuteReader(); while (obj_yw_export.Read()){ %>
                    <option value="<%= obj_yw_export["Tesco_Year"].ToString() %><%= obj_yw_export["Tesco_Week"].ToString() %>"><%= obj_yw_export["Tesco_Year"].ToString() %><%= obj_yw_export["Tesco_Week"].ToString() %> | <%= obj_yw_export["Between_Date"].ToString() %></option>
                <% } obj_yw_export.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Export To Excel" class="btn btn-default" onclick="js_export('YW_Export','1');" id="btnExportBackhaul" /></div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
