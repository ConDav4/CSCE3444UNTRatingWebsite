using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;

namespace CSCE3444UNTRatingWebsite
{
    public partial class courseprofile : System.Web.UI.Page
    {
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Users\\conda\\source\\repos\\CSCE3444UNTRatingWebsite\\CSCE3444Demo\\untrates.accdb";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourse();
            }
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        private void LoadCourse()
        {
            if (Request.QueryString["CourseID"] == null)
            {
                lblCourseName.Text = "Course not found.";
                return;
            }

            int courseID = Convert.ToInt32(Request.QueryString["CourseID"]);

            try
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();

                    string query = "SELECT * FROM Courses WHERE CourseID = ?";

                    OleDbCommand cmd = new OleDbCommand(query, conn);

                    cmd.Parameters.AddWithValue("@CourseID", courseID);

                    OleDbDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblCourseCode.Text = reader["CourseCode"].ToString();
                        lblCourseName.Text = reader["CourseName"].ToString();
                        lblDepartment.Text = reader["Department"].ToString();
                    }
                    else
                    {
                        lblCourseName.Text = "Course not found.";
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}