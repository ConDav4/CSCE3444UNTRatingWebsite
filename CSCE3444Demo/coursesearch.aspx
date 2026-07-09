<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="coursesearch.aspx.cs" Inherits="CSCE3444Demo.courseprofile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            height: 59px;
        }
        .auto-style3 {
            text-align: center;
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
                        <td class="auto-style1">Search for a Course</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2"></td>
                        <td class="auto-style3">&nbsp;<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                            &nbsp;
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                        </td>
                        <td class="auto-style2"></td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Courses] WHERE [CourseID] = ?" InsertCommand="INSERT INTO [Courses] ([CourseID], [CourseCode], [CourseName], [Department]) VALUES (?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Courses]" UpdateCommand="UPDATE [Courses] SET [CourseCode] = ?, [CourseName] = ?, [Department] = ? WHERE [CourseID] = ?" OnSelecting="SqlDataSource1_Selecting">
                                <DeleteParameters>
                                    <asp:Parameter Name="CourseID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="CourseID" Type="Int32" />
                                    <asp:Parameter Name="CourseCode" Type="String" />
                                    <asp:Parameter Name="CourseName" Type="String" />
                                    <asp:Parameter Name="Department" Type="String" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="CourseCode" Type="String" />
                                    <asp:Parameter Name="CourseName" Type="String" />
                                    <asp:Parameter Name="Department" Type="String" />
                                    <asp:Parameter Name="CourseID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td class="auto-style2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3">
                            <asp:GridView ID="CourseGrid" runat="server" DataSourceID="SqlDataSource1" Width="1115px" AutoGenerateColumns="False" DataKeyNames="CourseID">
                                <Columns>
                                    <asp:BoundField DataField="CourseID" HeaderText="CourseID" InsertVisible="False" ReadOnly="True" SortExpression="CourseID" />
                                    <asp:BoundField DataField="CourseCode" HeaderText="CourseCode" SortExpression="CourseCode" />
                                    <asp:BoundField DataField="CourseName" HeaderText="CourseName" SortExpression="CourseName" />
                                    <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                                </Columns>
                            </asp:GridView>
                        </td>
                        <td class="auto-style2">&nbsp;</td>
                    </tr>
                </table>
&nbsp;
            </asp:Content>


