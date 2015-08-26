<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="PrimaryHaul.WebUI.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Bootstrap core CSS -->
    <link href="dist/css/bootstrap.css" rel="stylesheet" />
    <link href="dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="dist/css/login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <div id="content">
            <div class="col-md-5"></div>
            <div class="col-md-7" style="margin-top:170px;">

                <div class="form-horizontal">
                    <!--h4>Use a local account to log in.</!--h4-->
                    <hr />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUserName" CssClass="col-md-4 col-xs-4 control-label">User Name</asp:Label>
                        <div class="col-md-8 col-xs-8">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtUserName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName"
                                CssClass="text-danger" ErrorMessage="The username field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="col-md-4 col-xs-4 control-label">Password</asp:Label>
                        <div class="col-md-8 col-xs-8">
                            <asp:TextBox autocomplete="off" runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-4 col-xs-offset-4 col-md-8 col-xs-8">
                            <asp:Button runat="server" ID="btnLogin" Text="Log in" CssClass="btn btn-default" OnClick="btnLogin_Click" />
                            <p class="text-danger">
                                <asp:Label ID="lblErr" runat="server"></asp:Label>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
