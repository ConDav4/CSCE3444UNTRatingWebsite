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
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Users\\conda\\source\\repos\\CSCE3444UNTRatingWebsite\\CSCE3444Demo\\untrates.accdb";

            using(OleDbConnection conn = new OleDbConnection(connectionString))
            {
                //check if user already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = ?";
                OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                int exists = (int)checkCmd.ExecuteScalar();
                if (exists > 0)
                {
                    lblMsg.Text = "Email already exists.";
                    return;
                }

                //insert new user
                string query = "INSERT INTO Users (FirstName, LastName, Email, Password) VALUES (?, ?, ?, ?)";
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    int accExists = Convert.ToInt32(checkCmd.ExecuteScalar());
                    if (accExists > 0)
                    { 
                        lblMsg.Text = "Registration failed. Please try again.";
                    }
                }
            }

            //Send to a page
            Response.Redirect("default.aspx");
            Session["user"] = null;
            Session["email"] = null;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtPassword.Text = "";
            txtPasswordConf.Text = "";
            txtEmail.Text = "";
            txtEmailConf.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}