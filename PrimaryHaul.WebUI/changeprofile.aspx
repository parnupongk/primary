<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="changeprofile.aspx.cs" Inherits="PrimaryHaul.WebUI.changeprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
    <div class="row">
        <div class="col-md-8">

            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Use a local account to change profile.</h4>
                    <hr />
                    <div id="divContact" runat="server" class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtContact" CssClass="col-md-3 control-label">Contact</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtContact" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContact" CssClass="text-danger" ErrorMessage="The Contact field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtMobile" CssClass="col-md-3 control-label">Mobile Number</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtMobile" CssClass="form-control" onkeypress="return isNumberKey(event)" MaxLength="10" />
                            <br/>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-md-3 control-label">Email</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-3 col-md-6">
                            <asp:Button runat="server" Text="Submit" ID="btnSubmit" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                            <p class="text-danger">
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </p>
                        </div>
                    </div>

                </div>
            </section>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
