<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="CSCE3444Demo.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            text-align: left;
        }
        .auto-style3 {
            width: 480px;
            text-align: right;
        }
        .auto-style4 {
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <asp:HyperLink ID="HomeLink" runat="server" NavigateUrl="~/default.aspx">Home</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="RegLink" runat="server" NavigateUrl="~/register.aspx">Register</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="LoginLink" runat="server" NavigateUrl="~/login.aspx">Login</asp:HyperLink>
&nbsp;|
                <table style="width:100%;">
                    <tr>
                        <td class="auto-style4" colspan="2">Welcome! Complete this form to register your account</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Email:</td>
                        <td class="auto-style1">&nbsp;<asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="RequiredFieldValidator">Email is required</asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Confirm Email: </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="txtEmailConf" runat="server"></asp:TextBox>
&nbsp;<asp:CompareValidator ID="cvEmail" runat="server" ControlToCompare="txtEmail" ControlToValidate="txtEmailConf" ErrorMessage="Emails must match"></asp:CompareValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Password:</td>
                        <td class="auto-style1">&nbsp;<asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="RequiredFieldValidator">Password is required</asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Confirm Password: </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="txtPasswordConf" runat="server"></asp:TextBox>
&nbsp;<asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtPasswordConf" ErrorMessage="CompareValidator">Passwords must match</asp:CompareValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">First Name: </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="RequiredFieldValidator">First Name is required</asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Last Name:</td>
                        <td class="auto-style1">&nbsp;<asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="RequiredFieldValidator">Last Name is required</asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">
                            <asp:Button ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Register" />
                        </td>
                        <td class="auto-style1">
                            <asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click" Text="Clear" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
                        </td>
                        <td class="auto-style1">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
&nbsp;
</asp:Content>


