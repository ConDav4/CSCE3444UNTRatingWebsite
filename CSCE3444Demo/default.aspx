<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="CSCE3444Demo._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            text-align: center;
            height: 280px;
        }
        .auto-style3 {
            text-align: center;
            height: 80px;
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
    &nbsp;<table style="width:100%;">
        <tr>
            <td class="auto-style3"></td>
            <td class="auto-style3">Welcome to the UNTRates</td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style2"></td>
            <td class="auto-style2"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style1">
                <asp:HyperLink ID="ProfSearchLink" runat="server" NavigateUrl="~/profsearch.aspx">Professor Search</asp:HyperLink>
            </td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style1">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/addprofessor.aspx">Add Professor</asp:HyperLink>
            </td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style1">
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/courseprofile.aspx">Course Search</asp:HyperLink>
            </td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style1">
                <asp:HyperLink ID="HyperLink4" runat="server">Add Course</asp:HyperLink>
            </td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
    </table>
&nbsp;
</asp:Content>

