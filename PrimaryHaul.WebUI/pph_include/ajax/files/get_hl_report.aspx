<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="get_hl_report.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.ajax.files.get_hl_report" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<% string sql = "Select Haulier_Abbr,Haulier_Name_En From Haulier_Info Where Haulier_Abbr in(select Distinct Haulier_Abbr From Transportation where year_week_upload='" + Request.Form["var01"].ToString() + "' and (Calc_Date is not null or Calc_Date<>'')) Order by Haulier_Name_En Asc"; %>
<select class="form-control" id="<%=Request.Form["var03"].ToString() %>" name="<%=Request.Form["var03"].ToString() %>">
    <option value="" selected="selected">เลือกทั้งหมด</option>
<% SqlCommand rs_hl_sum = new SqlCommand(sql, objConn); SqlDataReader obj_hl_sum = rs_hl_sum.ExecuteReader(); while (obj_hl_sum.Read()){ %>
<option value="<%= obj_hl_sum["Haulier_Abbr"].ToString() %>"><%= obj_hl_sum["Haulier_Name_En"].ToString() %></option>
<% } obj_hl_sum.Close(); %>
</select>