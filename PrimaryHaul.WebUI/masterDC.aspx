<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="masterDC.aspx.cs" Inherits="PrimaryHaul.WebUI.masterDC" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    <style type="text/css">
 .MyTabStyle .ajax__tab_header
        {
            font-family: "Helvetica Neue" , Arial, Sans-Serif;
            font-size: 14px;
            font-weight:bold;
            display: block;

        }
        .MyTabStyle .ajax__tab_header .ajax__tab_outer
        {
            border-color: #222;
            color: #222;
            padding-left: 10px;
            margin-right: 3px;
            border:solid 1px #d7d7d7;
        }
        .MyTabStyle .ajax__tab_header .ajax__tab_inner
        {
            border-color: #666;
            color: #666;
            padding: 3px 10px 2px 0px;
        }
        .MyTabStyle .ajax__tab_hover .ajax__tab_outer
        {
            background-color:#9c3;
        }
        .MyTabStyle .ajax__tab_hover .ajax__tab_inner
        {
            color: #fff;
        }
        .MyTabStyle .ajax__tab_active .ajax__tab_outer
        {
            border-bottom-color: #ffffff;
            background-color: #d7d7d7;
        }
        .MyTabStyle .ajax__tab_active .ajax__tab_inner
        {
            color: #000;
            border-color: #333;
        }
        .MyTabStyle .ajax__tab_body
        {
            font-family: verdana,tahoma,helvetica;
            font-size: 10pt;
            background-color: #fff;
            border-top-width: 0;
            border: solid 1px #d7d7d7;
            border-top-color: #ffffff;
        }
</style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="cpControl">
    
    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%" Height="500px" CssClass="MyTabStyle">
        <asp:TabPanel runat="server" HeaderText="Add Data DC" ID="tabAddDc" Height="100%" >

            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="form-horizontal">
                            <h4>Use a local account to log in.</h4>
                            <hr />
                            <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                                <p class="text-danger">
                                    <asp:Literal runat="server" ID="FailureText" />
                                </p>
                            </asp:PlaceHolder>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtDcNo" CssClass="col-md-2 control-label">DC No.</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox autocomplete="off" runat="server" ID="txtDcNo" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDcNo"
                                        CssClass="text-danger" ErrorMessage="The DC No. field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtDcName" CssClass="col-md-2 control-label">DC Name</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox autocomplete="off" runat="server" ID="txtDcName" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDcNo"
                                        CssClass="text-danger" ErrorMessage="The DC Name field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtStartDate" CssClass="col-md-2 control-label">Start Date</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox autocomplete="off" runat="server" ID="txtStartDate" CssClass="form-control" /><br />
                                    <asp:CalendarExtender ID="defaultCalendarExtender" Format="MM/dd/yyyy" runat="server" TargetControlID="txtStartDate" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <asp:Button runat="server" Text="Submit" ID="btnSubmit" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                                    <p class="text-danger">
                                        <asp:Label ID="lblError" runat="server"></asp:Label>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>

        </asp:TabPanel>

        <asp:TabPanel ID="tabViewDc" runat="server" HeaderText="View Data DC">
            <ContentTemplate>
                <asp:GridView ID="gvDc" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField HeaderText="No." />
                        <asp:BoundField HeaderText="DC No." />
                        <asp:BoundField HeaderText="DC Name" />
                        <asp:BoundField HeaderText="Start Date" />
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
                
            </ContentTemplate>
        </asp:TabPanel>

    </asp:TabContainer>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>

