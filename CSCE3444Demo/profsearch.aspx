<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="profsearch.aspx.cs" Inherits="CSCE3444UNTRatingWebsite.profsearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            text-align: center;
            height: 59px;
        }
        .auto-style3 {
            height: 59px;
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
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="auto-style1">Search for a Professor</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2"></td>
                        <td class="auto-style3" style="text-align: center">&nbsp;<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
&nbsp;
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                        </td>
                        <td class="auto-style2"></td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3" style="text-align: center">
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
                        </td>
                        <td class="auto-style2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3" style="text-align: center">
                            <asp:GridView ID="ProfessorGrid" runat="server" DataSourceID="SqlDataSource1" Width="1115px" AutoGenerateColumns="False" DataKeyNames="ProfessorID">
                                <Columns>
                                    <asp:BoundField DataField="ProfessorID" HeaderText="ProfessorID" InsertVisible="False" ReadOnly="True" SortExpression="ProfessorID" />
                                    <asp:BoundField DataField="ProfessorName" HeaderText="ProfessorName" SortExpression="ProfessorName" />
                                    <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                                    <asp:BoundField DataField="Rating" HeaderText="Rating" SortExpression="Rating" />
                                </Columns>
                            </asp:GridView>
                        </td>
                        <td class="auto-style2">&nbsp;</td>
                    </tr>
                </table>
&nbsp;
            </asp:Content>

