using CSC455RecipeManager.Areas.MvcArea.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;

namespace CSC455RecipeManager
{
    // http://www.hurryupandwait.io/blog/implementing-custom-membership-provider-and-role-provider-for-authenticating-asp-net-mvc-applications

    public class ConnectionProvider : MembershipProvider
    {
        private static readonly Regex UsernameRegex = new Regex("^\\w+$");
        private static readonly Regex PasswordSanitationRegex = new Regex("(['\"])");
        private static readonly int MaxPasswordLength = 100;
        private static string ValidResult = "True";

        public override bool EnablePasswordRetrieval => throw new NotImplementedException();

        public override bool EnablePasswordReset => throw new NotImplementedException();

        public override bool RequiresQuestionAndAnswer => throw new NotImplementedException();

        public override string ApplicationName { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public override int MaxInvalidPasswordAttempts => throw new NotImplementedException();

        public override int PasswordAttemptWindow => throw new NotImplementedException();

        public override bool RequiresUniqueEmail => throw new NotImplementedException();

        public override MembershipPasswordFormat PasswordFormat => throw new NotImplementedException();

        public override int MinRequiredPasswordLength => throw new NotImplementedException();

        public override int MinRequiredNonAlphanumericCharacters => throw new NotImplementedException();

        public override string PasswordStrengthRegularExpression => throw new NotImplementedException();

        public User User { get; private set; }
        public MySqlConnection Connection { get; private set; }

        public ConnectionProvider()
        {
            Connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["MySqlConnStr"].ConnectionString);
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            if (!UsernameRegex.IsMatch(username)
                || oldPassword.Length > MaxPasswordLength
                || newPassword.Length > MaxPasswordLength)
            {
                return false;
            }

            try
            {
                Connection.Open();

                MySqlCommand command = Connection.CreateCommand();
                String sanitizedOldPassword = PasswordSanitationRegex.Replace(oldPassword, "\\$1");
                String sanitizedNewPassword = PasswordSanitationRegex.Replace(newPassword, "\\$1");
                command.CommandText =
                    $"CALL ChangeUserPassword('{username}', '{sanitizedOldPassword}', '{sanitizedNewPassword}');";

                int numOfRowsAffected = command.ExecuteNonQuery();
                bool isSuccessful = numOfRowsAffected == 1;

                if (isSuccessful)
                {
                    User = new User { Username = username };
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occured: " + ex.Message);
                return false;
            }
            finally
            {
                Connection.Close();
            }
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            if (!UsernameRegex.IsMatch(username))
            {
                status = MembershipCreateStatus.InvalidUserName;
                return null;
            }
            if (password.Length > MaxPasswordLength)
            {
                status = MembershipCreateStatus.InvalidPassword;
                return null;
            }

            MySqlConnection Connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["MySqlConnStr"].ConnectionString);
            try
            {
                Connection.Open();

                MySqlCommand command = Connection.CreateCommand();
                String sanitizedPassword = PasswordSanitationRegex.Replace(password, "\\$1");
                command.CommandText =
                    $"CALL CreateUser('{username}', '{sanitizedPassword}');";

                int numOfRowsAffected = command.ExecuteNonQuery();
                bool isSuccessful = numOfRowsAffected == 1;

                if (isSuccessful)
                {
                    User = new User { Username = username };
                    status = MembershipCreateStatus.Success;
                    return null;
                }
                else
                {
                    status = MembershipCreateStatus.ProviderError;
                    return null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occured: " + ex.Message);
                status = MembershipCreateStatus.ProviderError;
                return null;
            }
            finally
            {
                Connection.Close();
            }
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override string GetUserNameByEmail(string email)
        {
            throw new NotImplementedException();
        }

        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override void UpdateUser(MembershipUser user)
        {
            throw new NotImplementedException();
        }

        public override bool ValidateUser(string username, string password)
        {
            if (!UsernameRegex.IsMatch(username)
                || password.Length > MaxPasswordLength)
            {
                return false;
            }

            MySqlConnection Connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["MySqlConnStr"].ConnectionString);
            MySqlDataReader reader = null;
            try
            {
                Connection.Open();

                MySqlCommand command = Connection.CreateCommand();
                String sanitizedPassword = PasswordSanitationRegex.Replace(password, "\\$1");
                command.CommandText =
                    $"SELECT ValidateUser('{username}', '{sanitizedPassword}') AS Result;";

                reader = command.ExecuteReader();
                reader.Read();
                bool isValid = reader["Result"].ToString() == ValidResult;

                if (isValid)
                {
                    User = new User { Username = username };
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occured: " + ex.Message);
                return false;
            }
            finally
            {
                Connection.Close();
                reader?.Close();
            }
        }
    }
}