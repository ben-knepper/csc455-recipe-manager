using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

namespace CSC455RecipeManager
{
    public partial class Login : System.Web.UI.Page
    {
        protected static Regex UsernameRegex = new Regex("^\\w+$");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignInButton_Clicked(object sender, EventArgs e)
        {
            try
            {
                MySqlConnection connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["MySqlConnStr"].ConnectionString);
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "CALL ValidateUser(";

                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                    Response.Write(reader["UserName"].ToString() + "<br />");
                reader.Close();

                connection.Close();
            }
            catch (Exception ex)
            {
                Response.Write("An error occured: " + ex.Message);
            }
        }

        protected void CancelSignInButton_Clicked(object sender, EventArgs e)
        {

        }
    }
}