<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="CSCE3444Demo.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 534px;
            height: 130px;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            text-align: right;
        }
        .auto-style4 {
            text-align: left;
        }
        .auto-style5 {
            height: 130px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <asp:HyperLink ID="HomeLink" runat="server" NavigateUrl="~/default.aspx">Home</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="RegLink" runat="server" NavigateUrl="~/register.aspx">Register</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="LoginLink" runat="server" NavigateUrl="~/login.aspx">Login</asp:HyperLink>
&nbsp;|&nbsp;
                <table style="width:100%;">
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style5"></td>
                    </tr>
                    <tr>
                        <td class="auto-style2" colspan="2">Welcome back! If you haven&#39;t registered an account yet, please register
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/register.aspx">here</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Email:</td>
                        <td class="auto-style4">&nbsp;<asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rvfEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Password: </td>
                        <td class="auto-style4">
                            <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rvfPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">
                            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
                        </td>
                        <td class="auto-style4">
                            <asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click" Text="Clear" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = ?" InsertCommand="INSERT INTO [Users] ([UserID], [Email], [Password], [FirstName], [LastName]) VALUES (?, ?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Users]" UpdateCommand="UPDATE [Users] SET [Email] = ?, [Password] = ?, [FirstName] = ?, [LastName] = ? WHERE [UserID] = ?" OnSelecting="SqlDataSource1_Selecting">
                                <DeleteParameters>
                                    <asp:Parameter Name="UserID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="UserID" Type="Int32" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:Parameter Name="Password" Type="String" />
                                    <asp:Parameter Name="FirstName" Type="String" />
                                    <asp:Parameter Name="LastName" Type="String" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:Parameter Name="Password" Type="String" />
                                    <asp:Parameter Name="FirstName" Type="String" />
                                    <asp:Parameter Name="LastName" Type="String" />
                                    <asp:Parameter Name="UserID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td class="auto-style4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2" colspan="2">
                            <asp:Label ID="lblMsg" runat="server" style="text-align: center"></asp:Label>
                        </td>
                    </tr>
                </table>
&nbsp;
</asp:Content>


