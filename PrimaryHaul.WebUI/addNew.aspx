<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="addNew.aspx.cs" Inherits="PrimaryHaul.WebUI.addNew" %>

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


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"
        type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
        rel="Stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            SearchText();
        });
        function SearchText() {
            $("#<%=txtTaxId.ClientID %>").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: '<%=ResolveUrl("~/AutoComplete.asmx/GetVendorCode") %>',
                    data: "{ 'prefixText': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0],
                                val: item.split('-')[1]
                            }
                        }))
                    },
                    error: function (result) {
                        alert(response.responseText);
                    }
                });
},
    focus: function () {
        // prevent value inserted on focus
        return false;
    },
    select: function (event, ui) {
        var terms = split(this.value);
        // remove the current input
        terms.pop();
        // add the selected item
        terms.push(ui.item.value);
        // add placeholder to get the comma-and-space at the end
        terms.push("");
        this.value = terms.join(", ");
        return false;
    }
});
        $("#<%=txtTaxId.ClientID %>").bind("keydown", function (event) {
        if (event.keyCode === $.ui.keyCode.TAB &&
        $(this).data("autocomplete").menu.active) {
            event.preventDefault();
        }
    })
    function split(val) {
        return val.split(/,\s*/);
    }
    function extractLast(term) {
        return split(term).pop();
    }
}
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">

    <div class="row">
        <div class="">

            <section id="loginForm">
                <div class="form-horizontal">
                    <h4><asp:Label ID="lblHeader" runat="server"></asp:Label></h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div id="divRole" runat="server" class="form-group">
                        <asp:Label runat="server" AssociatedControlID="rdoRoleAdmin1" CssClass="col-md-3 control-label">Role</asp:Label>
                        <div class="col-md-9">
                            <asp:RadioButton ID="rdoRoleAdmin1" runat="server" Checked="True" GroupName="rdoStatus" cssClass="radio-inline"  Text=" Admin1" />
                            &nbsp;<asp:RadioButton ID="rdoRoleAdmin2" runat="server" GroupName="rdoStatus" cssClass="radio-inline"  Text=" Admin2" />
                            &nbsp;&nbsp;
                        </div>

                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUserName" CssClass="col-md-3 control-label">User Name</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtUserName" CssClass="form-control" />
                            <asp:Label ID="lblErrUserName" CssClass="text-danger" runat="server"></asp:Label>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName"
                                CssClass="text-danger" ErrorMessage="The Username field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="col-md-3 control-label">Password</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPassword" CssClass="form-control" MaxLength="8" />
                            <asp:RegularExpressionValidator ID="regexpName" runat="server"
                                ErrorMessage="Passwords must have at least 8 characters and contain at least two of the following: uppercase letters, lowercase letters, numbers, and symbols."
                                ForeColor="Red" Font-Size="Small"
                                ControlToValidate="txtPassword"
                                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" />
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
                        <asp:Label runat="server" AssociatedControlID="txtPasswordConf" CssClass="col-md-3 control-label">Password Confirm</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPasswordConf" TextMode="Password" CssClass="form-control" MaxLength="8" />
                            <asp:CompareValidator runat="server" ID="Comp1" ForeColor="Red" ControlToValidate="txtPassword" ControlToCompare="txtPasswordConf" Text="These passwords don't match." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPasswrdExpried" CssClass="col-md-3 control-label">Password Expired Date</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPasswrdExpried" CssClass="form-control" Enabled="false" />
                            <br />
                        </div>
                    </div>
                    <div id="divHaulier" runat="server" class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtHaulierCode" CssClass="col-md-3 control-label">Haulier Code(Tax ID)</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtHaulierCode" CssClass="form-control" onkeypress="return isNumberKey(event)"   MaxLength="13" />
                            <asp:Label ID="lblErrHaulierCode" CssClass="text-danger" runat="server"></asp:Label>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                ErrorMessage="The Haulier Code(Tax ID) field is required."
                                ForeColor="Red"
                                ControlToValidate="txtHaulierCode"
                                ValidationExpression="\d{13}" />
                        </div>
                    </div>
                    <div id="divVender" runat="server" class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtTaxId" CssClass="col-md-3 control-label">Tax ID</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtTaxId" CssClass="form-control" onkeypress="return isNumberKey(event)" MaxLength="5" />
                            <asp:HiddenField ID="hfCustomerId" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTaxId" CssClass="text-danger" ErrorMessage="The Tax ID is required." />
                        </div>
                    </div>
                    <div id="divContact" runat="server" class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtContact" CssClass="col-md-3 control-label">Contact Point</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtContact" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContact" CssClass="text-danger" ErrorMessage="The Contact field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtEngName" CssClass="col-md-3 control-label">English Name</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtEngName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEngName" CssClass="text-danger" ErrorMessage="The Name field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtTHAName" CssClass="col-md-3 control-label">ชื่อภาษาไทย</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtTHAName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTHAName" CssClass="text-danger" ErrorMessage="The Name field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtMobile" CssClass="col-md-3 control-label">Mobile Number</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtMobile" CssClass="form-control" onkeypress="return isNumberKey(event)" MaxLength="10" />
                            <br />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-md-3 control-label">Email</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="rdoStatusA" CssClass="col-md-3 control-label">Status</asp:Label>
                        <div class="col-md-9">
                            <asp:RadioButton ID="rdoStatusA" runat="server" Checked="True" GroupName="rdoStatusA" cssClass="radio-inline"  Text="Active" />
                            &nbsp;<asp:RadioButton ID="rdoStatusD" runat="server" GroupName="rdoStatusA" cssClass="radio-inline"  Text="Deactive" />
                        </div>

                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-3 col-md-9">
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

</asp:Content>
