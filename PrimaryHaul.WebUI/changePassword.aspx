<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="changePassword.aspx.cs" Inherits="PrimaryHaul.WebUI.changePassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    <style>
        .BarIndicatorweak {
            color: Red;
            background-color: Red;
        }

        .BarIndicatoraverage {
            color: Blue;
            background-color: Blue;
        }

        .BarIndicatorgood {
            color: Green;
            background-color: Green;
        }

        .BarBorder {
            padding: 2px 2px 2px 2px;
            width: 200px;
            vertical-align: middle;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">

    <div class="row">
        <div class="col-md-12">

            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Profile > Change Password</h4>
                    <hr />

                    <div class="form-group">

                        <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="col-md-2 control-label">Password<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage=" * " /></asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPassword"  Width="200px" CssClass="form-control" MaxLength="8" />
                            <asp:RegularExpressionValidator ID="regexpName" runat="server"
                                ErrorMessage="Passwords must have at least 8 characters and contain at least two of the following: uppercase letters, lowercase letters, numbers, and symbols."
                                ForeColor="Red"
                                ControlToValidate="txtPassword"
                                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" />
                            <asp:PasswordStrength ID="PasswordStrength2"
                                runat="server"
                                TargetControlID="txtPassword"
                                RequiresUpperAndLowerCaseCharacters="true"
                                MinimumNumericCharacters="1"
                                MinimumSymbolCharacters="1"
                                MinimumUpperCaseCharacters="1"
                                PreferredPasswordLength="8"
                                DisplayPosition="RightSide"
                                StrengthIndicatorType="BarIndicator"
                                BarBorderCssClass="BarBorder"
                                StrengthStyles="BarIndicatorweak;BarIndicatoraverage;BarIndicatorgood;">
                            </asp:PasswordStrength>


                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPasswordConf" CssClass="col-md-2 control-label">Password Confirm<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPasswordConf" CssClass="text-danger" ErrorMessage=" * " /></asp:Label><div class="col-md-6">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPasswordConf"  Width="200px" TextMode="Password" CssClass="form-control" MaxLength="8" />
                            <asp:CompareValidator runat="server" ID="Comp1" ForeColor="Red" ControlToValidate="txtPasswordConf" ControlToCompare="txtPassword" Text=" These passwords don't match." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPasswordExpired"  CssClass="col-md-2 control-label">Password Expired</asp:Label><div class="col-md-6">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPasswordExpired"  Width="200px" CssClass="form-control" Enabled="false" />
                            <br />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-6">
                            <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
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
