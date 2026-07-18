using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.OleDb;

namespace CSCE3444Demo
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Users\\conda\\source\\repos\\CSCE3444UNTRatingWebsite\\CSCE3444Demo\\untrates.accdb";

            using(OleDbConnection conn = new OleDbConnection(connectionString))
            {
                string query = "SELECT Email, Password FROM Users WHERE Email = ?";
                OleDbCommand cmd = new OleDbCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                OleDbDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    // User exists, redirect to the next page
                    Response.Redirect("default.aspx");
                }
                else
                {
                    // User does not exist, show error message
                    lblMsg.Text = "Invalid email or password.";
                }
                conn.Close();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtPassword.Text = "";
            txtEmail.Text = "";
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}