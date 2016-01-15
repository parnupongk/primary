<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_dayweek.aspx.cs" Inherits="PrimaryHaul.WebUI.master_dayweek" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
 <script>
    function js_tab(varTab) {
        document.getElementById('form_view').style.display = 'none';
        document.getElementById('form_import').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
<div class="form-horizontal">
    <div id="form_button">
        <div class="row">
            <div class="col-md-4">
             <% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><input type="button" value="Import File" class="btn btn-default" onclick="js_tab('form_import');" />&nbsp;&nbsp;&nbsp;<%} %>
            <input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" />
            </div>
            <div class="col-md-8"></div>
        </div>
    </div>

    <div id="form_import" style="display:none;">
        <div class="col-md-12">
        <h4>Master > Date & Week‏ > Import File</h4>
        <hr /> 
        <div runat="server" class="form-group">
            <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label"></asp:Label>
            <div class="col-md-9">
                <a runat="server" id="lnkFile" href="file/dateweek.xlsx" target="_blank" >file ตัวอย่าง</a>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="AjaxFileUpload" CssClass="col-md-3 control-label">Import File :</asp:Label>
            <div class="col-md-9">

                <asp:AjaxFileUpload ID="AjaxFileUpload" runat="server" Padding-Bottom="4"
                        Padding-Left="2" Padding-Right="1" Padding-Top="4" ThrobberID="myThrobber" MaximumNumberOfFiles="10"
                        AllowedFileTypes="xls,vnd.ms-excel,xls,jpg,png,application/vnd.ms-excel,xlsx" OnUploadComplete="AjaxFileUpload_UploadComplete" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-3 col-md-9">
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                <p class="text-danger">
                    <asp:Label ID="lblErr" runat="server"></asp:Label>
                </p>
            </div>
        </div> 
        </div>
    </div>

    <div id="form_view" >
        <div class="row">
        <div class="col-md-12">
            <h4>Master > Date & Week‏</h4>
            <hr />
            <table class="table table-bordered">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;width:5%;">No.</td>
                <td style="text-align:center;width:5%;">Year</td>
                <td style="text-align:center;width:10%;">Tesco Wk</td>
                <td style="text-align:center;width:15%;">Tesco Period</td>
                <td style="text-align:center;width:10%;">Start Date</td>
                <td style="text-align:center;width:10%;">End Date</td>
                <td style="text-align:center;width:20%;">Between Date</td>
                <td style="text-align:center;width:15%;">Tesco FY</td>
                <td style="text-align:center;width:10%;"></td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0;
                int icolor = 0;
                string sql_dateweek = "select *, CONVERT(varchar(11),Period_StartDate,103) as Period_SStartDate, CONVERT(varchar(11),Period_EndDate,103) as Period_EEndDate from Date_Week_Info Order by Tesco_Year Desc , Tesco_Week Desc";
                SqlCommand rs_dateweek = new SqlCommand(sql_dateweek, objConn);
                SqlDataReader obj_dateweek = rs_dateweek.ExecuteReader();
                while (obj_dateweek.Read())
                {
                    irows++;
                    icolor++;
                    if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
            %>
              <tr <%= detailColor %>>
                <td style="text-align:center;"><%= irows %></td>
                <td style="text-align:center;"><%= obj_dateweek["Tesco_Year"].ToString() %></td>
                <td style="text-align:center;"><%= obj_dateweek["Tesco_Week"].ToString() %></td>
                <td style="text-align:center;"><%= obj_dateweek["Tesco_Period"].ToString() %></td>
                <td style="text-align:center;"><%= obj_dateweek["Period_SStartDate"].ToString() %></td>
                <td style="text-align:center;"><%= obj_dateweek["Period_EEndDate"].ToString() %></td>
                <td style="text-align:center;"><%= obj_dateweek["Between_Date"].ToString() %></td>
                <td style="text-align:center;"><%= obj_dateweek["Tesco_FY"].ToString() %></td>
                <td style="text-align:center;"> <% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><input type="button" value="Edit" class="btn btn-default" <% Response.Write("onclick=\"window.location.href='./master_dayweek.aspx?id=" + Request.QueryString["id"].ToString() + "&r=" + Request.QueryString["r"].ToString() + "&Wk_ID=" + obj_dateweek["Wk_ID"].ToString() + "';\""); %> /><%} %></td>                   
              </tr>
             <% } obj_dateweek.Close(); %>
            </table>
            </div>
        </div>       
    </div>
</div>

<% if (!string.IsNullOrEmpty(Request.QueryString["Wk_ID"] as string)){ %>
<script>
    document.getElementById('form_button').style.display = 'none';
    document.getElementById('form_view').style.display = 'none';
    document.getElementById('form_import').style.display = 'none';
</script>
<div class="row">
    <div class="col-md-2"><input type="button" value="Back" class="btn btn-default" <% Response.Write("onclick=\"window.location.href='./master_dayweek.aspx?r=" + Request.QueryString["r"].ToString() + "&id=" + Request.QueryString["id"].ToString() + "';\""); %>onclick="window.history.back();" style="width:100%;" /></div>
    <div class="col-md-2"></div>
    <div class="col-md-8"></div>
</div>
<br />
<script>
    function edit_dateweek(varA, varB) {
        var req = Inint_AJAX();
        var str = Math.random();
        var strS = document.getElementById('Period_StartDate').value;
        var strE = document.getElementById('Period_EndDate').value;
        var strID = document.getElementById('hid_Wk_ID').value;
        var strYear = document.getElementById('Tesco_Year').value;
        var strWeek = document.getElementById('Tesco_Week').value;
        var strFY = document.getElementById('Tesco_FY').value;
        var strTP = document.getElementById('Tesco_Period').value;
        var str_url_address = "./pph_include/ajax/files/edit_dateweek.aspx";
        var str_url = "var01=" + strS;
        str_url += "&var02=" + strE;
        str_url += "&var03=" + strID;
        str_url += "&var04=" + strYear;
        str_url += "&var05=" + strWeek;
        str_url += "&var06=" + strFY;
        str_url += "&var07=" + strTP;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    alert('Save Success');
                    window.location.href = './master_dayweek.aspx?r=' + varA + '&id=' + varB;
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
</script>
<div id="form_edit">
<%
       string sql_edit = "select Wk_ID, CONVERT(varchar(11),Period_StartDate,103) as Period_StartDate, CONVERT(varchar(11),Period_EndDate ,103) as Period_EndDate, Tesco_Year, Tesco_Week, Tesco_FY, Tesco_Period  from Date_Week_Info  where Wk_ID ='" + Request.QueryString["Wk_ID"] + "'";
    SqlCommand rs_edit = new SqlCommand(sql_edit, objConn);
    SqlDataReader obj_edit = rs_edit.ExecuteReader();
    obj_edit.Read();
%>
<div class="row">
     <div class="col-md-12">
        <h4>Master > Date & Week‏ > Edit</h4>
        <hr />  
         <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Year</label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" autocomplete="off" name="Tesco_Year" id="Tesco_Year" style="width:100%;" value="<%=obj_edit[3].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
         <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Tesco Wk</label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" autocomplete="off" name="Tesco_Week" id="Tesco_Week" style="width:100%;" value="<%=obj_edit[4].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Tesco Period</label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" autocomplete="off" name="Tesco_Period" id="Tesco_Period" style="width:100%;" value="<%=obj_edit[6].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Start Date </label></div>
                <div class="col-md-3">
                    <input type="hidden" class="form-control" id="hid_Wk_ID" name="hid_Wk_ID" value="<%= obj_edit[0].ToString() %>" />
                    <input type="text" class="form-control" autocomplete="off" name="Period_StartDate" id="Period_StartDate" style="width:100%;" value="<%=obj_edit[1].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
         <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">End Date </label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" autocomplete="off" name="Period_EndDate" id="Period_EndDate" style="width:100%;" value="<%=obj_edit[2].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
         <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Tesco FY</label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" autocomplete="off" name="Tesco_FY" id="Tesco_FY" style="width:100%;" value="<%=obj_edit[5].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;">
                </div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnEdit" value="Save" class="btn btn-default"  <% Response.Write("onclick=\"edit_dateweek('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "');\""); %> /><p class="text-danger" id="btnEditSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</div>
<% } %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="./pph_include/jquery/jquery-ui.js"></script>
<script>

    $(function () {

        $("#Period_StartDate").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#Period_EndDate").datepicker({ dateFormat: 'dd/mm/yy', minDate: 0 });
    });

</script>
<style>
    div.ui-datepicker{
        font-size:14px;
    }
</style> 
</asp:Content>
