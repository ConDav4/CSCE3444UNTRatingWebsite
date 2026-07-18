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
    public partial class addprofessor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Users\\conda\\source\\repos\\CSCE3444UNTRatingWebsite\\CSCE3444Demo\\untrates.accdb";
            string name = txtProfName.Text;
            string dpt = txtDpt.Text;

            try
            {
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    string query = "INSERT INTO Professors (ProfessorName, Department) VALUES (?, ?)";
                    OleDbCommand cmd = new OleDbCommand(query, conn);
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@dpt", dpt);
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        lblMsg.Text = "Professor added successfully!";
                    }
                    else
                    {
                        lblMsg.Text = "Error adding professor.";
                    }

                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}