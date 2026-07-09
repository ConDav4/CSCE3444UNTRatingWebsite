using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.OleDb;

namespace CSCE3444UNTRatingWebsite
{
    public partial class addcourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string courseCode = txtCourseCode.Text;
            string courseName = txtCourseName.Text;
            string dpt = txtDpt.Text;
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Users\\conda\\source\\repos\\CSCE3444UNTRatingWebsite\\CSCE3444Demo\\untrates.accdb";

            using(OleDbConnection conn = new OleDbConnection(connectionString))
            {
                string query = "INSERT INTO Courses (CourseCode, CourseName, Department) VALUES (?, ?, ?)";
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("@courseCode", courseCode);
                cmd.Parameters.AddWithValue("@courseName", courseName);
                cmd.Parameters.AddWithValue("@dpt", dpt);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblMsg.Text = "Course added successfully!";
                }
                else
                {
                    lblMsg.Text = "Error adding course.";
                }
                conn.Close();
            }
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}