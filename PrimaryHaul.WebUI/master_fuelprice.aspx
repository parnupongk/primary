<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_fuelprice.aspx.cs" Inherits="PrimaryHaul.WebUI.master_fuelprice" %>
<%@ Import Namespace="PrimaryHaul_WS"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<div class="row">
            <div class="col-md-8">
                <section id="loginForm">
                    <div class="form-horizontal">
                        <h4>Master > Fuel Rate</h4>
                        <hr />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtFuelRate" CssClass="col-md-2 control-label">Fuel Rate</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox autocomplete="off" runat="server" ID="txtFuelRate" Width="150px" onkeypress="return isNumberKey(event)" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFuelRate"
                                    CssClass="text-danger" ErrorMessage="Fuel Rate field is required." />
                            </div>
                        </div>
                         <% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" ID="btnSubmit" Text="Save" CssClass="btn btn-default" OnClick="btnSubmit_Click"  />
                                <p class="text-danger">
                                    <asp:Label ID="lblErr" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                        <%} %>
                    </div>
                </section>
            </div>
        </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
