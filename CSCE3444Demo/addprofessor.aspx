<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addprofessor.aspx.cs" Inherits="CSCE3444Demo.addprofessor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            text-align: left;
        }
        .auto-style2 {
        }
        .auto-style3 {
            height: 26px;
        }
        .auto-style4 {
            height: 26px;
            width: 519px;
        }
        .auto-style5 {
            width: 519px;
        }
        .auto-style6 {
            width: 519px;
            text-align: right;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <asp:HyperLink ID="HomeLink" runat="server" NavigateUrl="~/default.aspx">Home</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="RegLink" runat="server" NavigateUrl="~/register.aspx">Register</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="LoginLink" runat="server" NavigateUrl="~/login.aspx">Login</asp:HyperLink>
&nbsp;|&nbsp;&nbsp;&nbsp;
                <table style="width:100%;">
                    <tr>
                        <td class="auto-style2" colspan="2">Add a Professor using the fields below</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style4"></td>
                        <td class="auto-style3"></td>
                        <td class="auto-style3"></td>
                    </tr>
                    <tr>
                        <td class="auto-style6">Professor Name:</td>
                        <td class="auto-style1">
                            <asp:TextBox ID="txtProfName" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rfvProfName" runat="server" ControlToValidate="txtProfName" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style6">Department:</td>
                        <td class="auto-style1">&nbsp;<asp:TextBox ID="txtDpt" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="rfvDpt" runat="server" ControlToValidate="txtDpt" ErrorMessage="Department is required"></asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style5">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style5">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Professors] WHERE [ProfessorID] = ?" InsertCommand="INSERT INTO [Professors] ([ProfessorID], [ProfessorName], [Department], [Rating]) VALUES (?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Professors]" UpdateCommand="UPDATE [Professors] SET [ProfessorName] = ?, [Department] = ?, [Rating] = ? WHERE [ProfessorID] = ?" OnSelecting="SqlDataSource1_Selecting">
                                <DeleteParameters>
                                    <asp:Parameter Name="ProfessorID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ProfessorID" Type="Int32" />
                                    <asp:Parameter Name="ProfessorName" Type="String" />
                                    <asp:Parameter Name="Department" Type="String" />
                                    <asp:Parameter Name="Rating" Type="Double" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ProfessorName" Type="String" />
                                    <asp:Parameter Name="Department" Type="String" />
                                    <asp:Parameter Name="Rating" Type="Double" />
                                    <asp:Parameter Name="ProfessorID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
&nbsp;
</asp:Content>


