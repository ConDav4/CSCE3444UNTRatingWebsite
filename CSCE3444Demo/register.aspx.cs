using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CSCE3444Demo
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            //Wait for DB to be set up and then implement this function to register a new user

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
    }
}