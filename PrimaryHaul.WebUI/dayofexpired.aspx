<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="dayofexpired.aspx.cs" Inherits="PrimaryHaul.WebUI.dayofexpired" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
    <div class="row">
            <div class="col-md-8">
                <section id="loginForm">
                    <div class="form-horizontal">
                        <h4>Profile > Day of Expired Date</h4>
                        <hr />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtDayofExpired" CssClass="col-md-2 control-label">Day of Expired</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox autocomplete="off" runat="server" ID="txtDayofExpired" Width="150px" onkeypress="return isNumberKey(event)" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDayofExpired"
                                    CssClass="text-danger" ErrorMessage="The Day of Expired field is required." />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click"  />
                                <p class="text-danger">
                                    <asp:Label ID="lblErr" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

        </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
