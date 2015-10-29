<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="get_vd_report.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.ajax.files.get_vd_report" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<select class="form-control" id="<%=Request.Form["var03"].ToString() %>" name="<%=Request.Form["var03"].ToString() %>">
    <option value="" selected="selected">เลือกทั้งหมด</option>
<% string sql = "select distinct V.VendorID,V.Vendor_Name_En from Transportation T,Vendor_Info V,Vendor_Group G where T.Vendor_Code=G.Vendor_Code and G.VendorID=V.VendorID and Year_Week_Upload='" + Request.Form["var01"].ToString() + "' and (Calc_Date is not null or Calc_Date<>'') Order by V.Vendor_Name_En"; SqlCommand rs_vd_sum = new SqlCommand(sql, objConn); SqlDataReader obj_vd_sum = rs_vd_sum.ExecuteReader(); while (obj_vd_sum.Read())
   { %>
<option value="<%= obj_vd_sum["VendorID"].ToString() %>"><%= obj_vd_sum["Vendor_Name_En"].ToString() %></option>
<% } obj_vd_sum.Close(); %>
</select>
