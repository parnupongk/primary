<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="user_management.aspx.cs" Inherits="PrimaryHaul.WebUI.user_management" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_submitSearch(varType, varText, varUrl)
    {
        strType = document.getElementById(varType).value;
        strText = document.getElementById(varText).value;
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl + '&search_usertype=' + strType + '&search_text=' + strText;
    }
</script>
<%
    string str_usertype = "All";
    string str_text = "";
    if (!string.IsNullOrEmpty(Request.QueryString["search_usertype"] as string))
    {
        str_usertype = Request.QueryString["search_usertype"].ToString();
    }

    if (!string.IsNullOrEmpty(Request.QueryString["search_text"] as string))
    {
        str_text = Request.QueryString["search_text"].ToString();
    }
%>
<div class="row"><div class="col-md-12"><div class="form-horizontal"><h4>Profile > User Management</h4><hr /></div></div></div>
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<div class="form-group">
<div class="row">
    <div class="col-md-2" style="text-align:right;"><label class="control-label">User Type : </label></div>
    <div class="col-md-3">
        <select class="form-control" id="search_usertype" name="search_usertype">
            <option value="All" selected="selected" <% if (str_usertype == "All") { Response.Write("selected"); } %>>All</option>
            <% while (obj_usertype.Read()){ %>
                <option value="<%= obj_usertype["RoleID"].ToString() %>" <% if (str_usertype == obj_usertype["RoleID"].ToString()) { Response.Write("selected"); } %>><%= obj_usertype["Group_Menu"].ToString() %> (<%= obj_usertype["RoleID"].ToString() %>)</option>
            <% } obj_usertype.Close(); %>
        </select>
    </div>
    <div class="col-md-7"></div>
</div>
</div>
<div class="form-group">
<div class="row">
    <div class="col-md-2" style="text-align:right;"><label class="control-label">Username : </label></div>
    <div class="col-md-3"><input type="text" class="form-control" name="search_text" id="search_text" value="<%= str_text %>" /></div>
    <div class="col-md-7" style="text-align:left;"><input type="button" value="Search" class="btn btn-default" onclick="js_submitSearch('search_usertype',  'search_text' , 'urlSubmit');" /></div>
</div>
</div>
<% if (!string.IsNullOrEmpty(Request.QueryString["search_usertype"] as string)){ %>
<div class="row">
    <div class="col-md-12">
    <table class="table table-bordered">
    <tr style="background-color:#9bbb59;">
        <td style="text-align:center;">No.</td>
        <td style="text-align:center;">Username</td>
        <td style="text-align:center;">Password Expired Date</td>
        <td style="text-align:center;">Full Name En</td>
        <td style="text-align:center;">Contact Person</td>
        <td style="text-align:center;">Telephone</td>
        <td style="text-align:center;">Mobile</td>
        <td style="text-align:center;">E-mail</td>
        <td style="text-align:center;">User Status</td>
        <td style="text-align:center;">Management Status</td>
    </tr>
    <%
    if (txtType != "")
        {
            string detailColor = "", detailStatus = "", urlUpdateStatus = "", urlReset = "";
            int irows = 0;
            int icolor = 0;
            string searchRole = "";
            if (txtType != "All") { searchRole = "and RoleID='" + txtType + "'"; }
            string sql_listuser = "select * from User_Profile where UserID != '' " + searchRole + " " + txtText + " order by UserID asc";
            SqlCommand rs_listuser = new SqlCommand(sql_listuser, objConn);
            obj_listuser = rs_listuser.ExecuteReader();
            while (obj_listuser.Read())
            {
                irows++;
                icolor++;
                if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
                if (obj_listuser["User_Status"].ToString() == "A") { detailStatus = "Active"; urlUpdateStatus = "window.location.href='./pph_include/module/profile/user_management/update_status.aspx?url=" + PPHfunction.encodeBase64("/user_management.aspx" + HttpContext.Current.Request.Url.Query) + "&id=" + obj_listuser["UserID"].ToString() + "&status=D&force=N';"; } else { detailStatus = "Deactive"; urlUpdateStatus = "window.location.href='./pph_include/module/profile/user_management/update_status.aspx?url=" + PPHfunction.encodeBase64("/user_management.aspx" + HttpContext.Current.Request.Url.Query) + "&id=" + obj_listuser["UserID"].ToString() + "&status=A&force=Y';"; }
                urlReset = "window.location.href='./pph_include/module/profile/user_management/reset_password.aspx?url=" + PPHfunction.encodeBase64("/user_management.aspx" + HttpContext.Current.Request.Url.Query) + "&Param=" + PPHfunction.encodeBase64(obj_listuser["UserID"].ToString()) + "';";
    %>
      <tr <%= detailColor %>>
        <td style="text-align:center;"><%= irows %></td>
        <td style="text-align:center;"><%= obj_listuser["UserName"].ToString() %></td>
        <td style="text-align:center;"><%= obj_listuser["Passwd_Expired_Date"].ToString() %></td>
        <td style="text-align:center;"><%= obj_listuser["FullName_En"].ToString() %></td>
        <td style="text-align:center;"><%= obj_listuser["Contact_Person"].ToString() %></td>
        <td style="text-align:center;"><%= obj_listuser["Telephone_Office"].ToString() %></td>
        <td style="text-align:center;"><%= obj_listuser["Mobile"].ToString() %></td>
        <td style="text-align:center;"><%= obj_listuser["EMail_Address"].ToString() %></td>
        <td style="text-align:center;"><%= detailStatus %></td>
        <td style="text-align:center;">
            <input type="button" value="Reset Password" id="btnResetPass" class="btn btn-default" onclick="<%= urlReset %>" /> 
            <input type="button" value="Status" class="btn btn-default" onclick="<%= urlUpdateStatus %>" />
        </td>                   
      </tr>
     <% } obj_listuser.Close();
        }%>
    </table>
    </div>
</div>
<% } %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
