using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CSCE3444Demo
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //declare variable for credentials, temporary admin user only while waiting for DB to be set up
            string sUID = "admin";
            string sPass = "password";
            string sUser = "admin";

            //gather query results from DB and compare with user input

            if (txtEmail.Text == sUID && txtPassword.Text == sPass)
            {
                Session["user"] = sUser;
                Session["email"] = sUID;
                Response.Redirect("success.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid email or password.";
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtPassword.Text = "";
            txtEmail.Text = "";
        }
    }
}