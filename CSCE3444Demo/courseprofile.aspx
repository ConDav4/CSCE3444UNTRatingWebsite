<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="courseprofile.aspx.cs" Inherits="CSCE3444UNTRatingWebsite.courseprofile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
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
&nbsp;|&nbsp;&nbsp;&nbsp;
                <table style="width:100%;">
                    <tr>
                        <td>&nbsp;</td>
                        <td class="auto-style1">
                            <asp:Label ID="lblCourseName" runat="server"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="auto-style1">
                            <asp:Label ID="lblCourseCode" runat="server"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="auto-style1">
                            <asp:Label ID="lblDepartment" runat="server"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="auto-style1">Reviews:</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="auto-style1">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="RatingID" DataSourceID="SqlDataSource1" AllowSorting="True">
                                <Columns>
                                    <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" />
                                    <asp:BoundField DataField="CourseID" HeaderText="CourseID" SortExpression="CourseID" />
                                    <asp:BoundField DataField="Score" HeaderText="Score" SortExpression="Score" />
                                    <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
                                    <asp:BoundField DataField="DatePosted" HeaderText="DatePosted" SortExpression="DatePosted" />
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Ratings] WHERE [RatingID] = ?" InsertCommand="INSERT INTO [Ratings] ([RatingID], [ProfessorID], [UserID], [CourseID], [Score], [Comment], [DatePosted]) VALUES (?, ?, ?, ?, ?, ?, ?)" OnSelecting="SqlDataSource1_Selecting" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Ratings]" UpdateCommand="UPDATE [Ratings] SET [ProfessorID] = ?, [UserID] = ?, [CourseID] = ?, [Score] = ?, [Comment] = ?, [DatePosted] = ? WHERE [RatingID] = ?">
                                <DeleteParameters>
                                    <asp:Parameter Name="RatingID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="RatingID" Type="Int32" />
                                    <asp:Parameter Name="ProfessorID" Type="Int32" />
                                    <asp:Parameter Name="UserID" Type="Int32" />
                                    <asp:Parameter Name="CourseID" Type="Int32" />
                                    <asp:Parameter Name="Score" Type="Int32" />
                                    <asp:Parameter Name="Comment" Type="String" />
                                    <asp:Parameter Name="DatePosted" Type="DateTime" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ProfessorID" Type="Int32" />
                                    <asp:Parameter Name="UserID" Type="Int32" />
                                    <asp:Parameter Name="CourseID" Type="Int32" />
                                    <asp:Parameter Name="Score" Type="Int32" />
                                    <asp:Parameter Name="Comment" Type="String" />
                                    <asp:Parameter Name="DatePosted" Type="DateTime" />
                                    <asp:Parameter Name="RatingID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
&nbsp;
</asp:Content>

