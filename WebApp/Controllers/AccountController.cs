using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using WebApp.DataBase;
using WebApp.Models;

namespace WebApp.Controllers
{
    public class AccountController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CheckLogin(Account user)
        {
            SqlConnection con = DBServices.openConnection();

            SqlCommand command;
            SqlDataReader dataReader;

            string sql;
            sql = "SELECT UserId, UserName, PhoneNumber, IDCardNumber, Address, Password,Email, Type" +
                " FROM Account WHERE UserId = @USERID AND Password = @PASSWORD";

            command = new SqlCommand(sql, con);
            command.Parameters.Add("@USERID", SqlDbType.NVarChar).Value = user.UserId;
            command.Parameters.Add("@PASSWORD", SqlDbType.NVarChar).Value = user.Password;
            dataReader = command.ExecuteReader();
            if (dataReader.Read())
            {
                string UserId;
                string UserName;
                string PhoneNumber = "";
                string IDCardNumber = "";
                string Address = "";
                string Password;
                string Email = "";
                int Type;
                UserId = dataReader.GetString(0);
                UserName = dataReader.GetString(1);
                if (dataReader["PhoneNumber"] != DBNull.Value)
                {
                    PhoneNumber = dataReader.GetString(2);
                }
                if (dataReader["IDCardNumber"] != DBNull.Value)
                {
                    IDCardNumber = dataReader.GetString(3);
                }
                if (dataReader["Address"] != DBNull.Value)
                {
                    Address = dataReader.GetString(4);
                }
                Password = dataReader.GetString(5);
                if (dataReader["Email"] != DBNull.Value)
                {
                    Email = dataReader.GetString(6);
                }
                
                Debug.WriteLine("email: "+ Email);
                Type = dataReader.GetInt32(7);
                Account tmp = new Account(UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type);
                tmp.Email = Email;
                Session["USER"] = tmp;
                dataReader.Close();
                command.Dispose();
                con.Close();
                return RedirectToAction("Search", "Search");
            }
            dataReader.Close();
            command.Dispose();
            con.Close();

            return View("Index");
        }

        public ActionResult ApiLogin(string id, string name, int type)
        {
            Debug.WriteLine(id + "----" + type+"----"+name);

            Account tmp = GetAccount(id, type);
            if (tmp == null)
            {
                SqlConnection con = DBServices.openConnection();
                string query = "INSERT INTO " +
                    "Account(UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type) " +
                    "VALUES(@USERID, @USERNAME, @PHONENUMBER, @IDCARDNUMBER, @ADDRESS, @PASSWORD, @TYPE)";
                SqlCommand command = new SqlCommand(query, con);
                command.Parameters.Add("@USERID", SqlDbType.NVarChar).Value = id;
                command.Parameters.Add("@USERNAME", SqlDbType.NVarChar).Value = name;
                command.Parameters.Add("@PHONENUMBER", SqlDbType.NVarChar).Value = "";
                command.Parameters.Add("@IDCARDNUMBER", SqlDbType.NVarChar).Value = "";
                command.Parameters.Add("@ADDRESS", SqlDbType.NVarChar).Value = "";
                command.Parameters.Add("@PASSWORD", SqlDbType.NVarChar).Value = "";
                command.Parameters.Add("@TYPE", SqlDbType.Int).Value = type;
                command.ExecuteNonQuery();
                tmp = new Account() { UserId = id, UserName = name, PhoneNumber = "", IDCardNumber = "", Address = "", Password = "", Type = type };
            }
            Session["USER"] = tmp;
            return RedirectToAction("Search", "Search");
        }

        public Account GetAccount(string id, int type)
        {
            Debug.WriteLine(id + "----" + type);
            SqlConnection con = DBServices.openConnection();
            SqlCommand command = null;
            SqlDataReader dataReader = null;
            string sql = "SELECT UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type " +
                "FROM Account WHERE UserId = @USERID AND Type = @TYPE";
            command = new SqlCommand(sql, con);
            command.Parameters.Add("@USERID", SqlDbType.NVarChar).Value = id;
            command.Parameters.Add("@TYPE", SqlDbType.Int).Value = type;
            dataReader = command.ExecuteReader();
            if (dataReader.Read())
            {
                string UserId;
                string UserName;
                string PhoneNumber = "";
                string IDCardNumber = "";
                string Address = "";
                string Password;
                int Type;
                UserId = dataReader.GetString(0);
                UserName = dataReader.GetString(1);
                if (dataReader["PhoneNumber"] != null)
                {
                    PhoneNumber = dataReader.GetString(2);
                }
                if (dataReader["IDCardNumber"] != DBNull.Value)
                {
                    IDCardNumber = dataReader.GetString(3);
                }
                if (dataReader["Address"] != null)
                {
                    Address = dataReader.GetString(4);
                }
                Password = dataReader.GetString(5);
                Type = dataReader.GetInt32(6);
                Account tmp = new Account(UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type);
                return tmp;
            }
            return null;
        }

        public ActionResult Register()
        {
            return View();
        }

        public ActionResult Dangky(Account dto)
        {
            bool err = false;
            if (!ModelState.IsValid)
            {
                Debug.WriteLine("loi1");
                err = true;
            }
            if (dto.UserId == null)
            {
                Debug.WriteLine("loi4");
                err = true;
            }
            else if (!checkDuplicateID(dto.UserId))
            {
                Debug.WriteLine("loi2" + dto.UserId);
                ViewBag.DuplicateId = "This UserId already exist!";
                err = true;
            }
            if (dto.ConfirmPassword == null)
            {
                Debug.WriteLine("loi3");
                ViewBag.ConfirmNotMatchErr = "Required!";
                err = true;
            }
            else if (!dto.Password.Equals(dto.ConfirmPassword))
            {
                ViewBag.ConfirmNotMatchErr = "Confirm Password Not Match!";
                err = true;
            }
            if (err)
            {
                return View("Register");
            }
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = "INSERT INTO Account(UserId,UserName,PhoneNumber,Email,IDCardNumber,Address,Password,Type) " +
            "VALUES (@UserID,@UserName,@PhoneNumber,@Email,@IDCardNumber,@Address,@Password,1)";
            command.Parameters.Add("@UserID", SqlDbType.VarChar, 10).Value = dto.UserId;
            command.Parameters.Add("@UserName", SqlDbType.NVarChar, 50).Value = dto.UserName;
            command.Parameters.Add("@PhoneNumber", SqlDbType.NVarChar, 50).Value = dto.PhoneNumber;
            command.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = dto.Email;
            command.Parameters.Add("@IDCardNumber", SqlDbType.NVarChar, 500).Value = dto.IDCardNumber;
            command.Parameters.Add("@Address", SqlDbType.NVarChar, 500).Value = dto.Address;
            command.Parameters.Add("@Password", SqlDbType.NVarChar, 500).Value = dto.Password;

            int rs = command.ExecuteNonQuery();
            if (rs > 0)
            {
                con.Close();
                return View("Index");
            }
            con.Close();
            return View("Register");

        }

        public ActionResult AccountPage()
        {
            return View();
        }

        public ActionResult UpdateDetail(Account upUser)
        {
            bool err = false;
            SqlConnection con = DBServices.openConnection();
            SqlCommand command = null;
            string sql = "UPDATE Account " +
                        "SET UserName = @Name" +
                        ",PhoneNumber = @PhoneNumber" +
                        ",Email = @Email" +
                        ",IDCardNumber = @IDCardNumber" +
                        ",Address = @Address" +
                        " WHERE UserID = @ID";
            command = new SqlCommand(sql, con);
            command.Parameters.Add("@ID", SqlDbType.NVarChar, 50).Value = upUser.UserId;
            #region Validate Data
            if (upUser.UserName == null)
            {
                ViewBag.UserNameErr = "Please enter username!";
                err = true;
            }
            else if (upUser.UserName.Trim().Equals(""))
            {
                ViewBag.UserNameErr = "Please enter username!";
                err = true;
            }
            else if (upUser.UserName != null)
            {
                command.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = upUser.UserName;
            }

            if (upUser.PhoneNumber == null)
            {
                ViewBag.PhoneNumberErr = "Please enter Phonenumber!";
                err = true;
            }
            else if(!Regex.Match(upUser.PhoneNumber, @"^(0[0-9]{9})$").Success)
            {
                ViewBag.PhoneNumberErr = "Please enter corect Phonenumber!";
                err = true;
            }
            else if (upUser.PhoneNumber != null)
            {
                command.Parameters.Add("@PhoneNumber", SqlDbType.VarChar, 12).Value = upUser.PhoneNumber;
            }


            //command.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = upUser.Email;
            if (upUser.Email == null)
            {
                ViewBag.EmailErr = "Please enter Email!";
                err = true;
            }
            else if(!Regex.Match(upUser.Email, @"^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-‌​]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$").Success)
            {
                ViewBag.EmailErr = "Please enter corect Email !";
                err = true;
            }
            else if(upUser.Email != null)
            {
                command.Parameters.Add("@Email", SqlDbType.NVarChar).Value = upUser.Email;
            }



            if (upUser.IDCardNumber != null)
            {
                command.Parameters.Add("@IDCardNumber", SqlDbType.NVarChar).Value = upUser.IDCardNumber;
            }
            else
            {
                command.Parameters.Add("@IDCardNumber", SqlDbType.NVarChar).Value = "";
            }


            if (upUser.Address != null)
            {
                command.Parameters.Add("@Address", SqlDbType.NVarChar, 100).Value = upUser.Address;
            }
            else
            {
                command.Parameters.Add("@Address", SqlDbType.NVarChar, 100).Value = "";
            }
            #endregion

            if (err)
            {
                return View("AccountPage");
            }
            if (command.ExecuteNonQuery() > 0)
            {
                Account tmp = (Account)Session["User"];
                tmp.UserName = upUser.UserName;
                tmp.PhoneNumber = upUser.PhoneNumber;
                tmp.Email = upUser.Email;
                tmp.IDCardNumber = upUser.IDCardNumber;
                tmp.Address = upUser.Address;
                Session["User"] = tmp;
            }
            con.Close();
            //return Content("Check");
            return RedirectToAction("Search", "Search");
        }
        public ActionResult UpdatePassword()
        {
            Account curAcc = (Account)Session["User"];
            string id = Request.Params["UserID"];
            string oldPass = Request.Params["Password"];
            string newPass = Request.Params["NewPassword"];
            string confirm = Request.Params["ConfirmPassword"];

            string errStr = "";
            bool err = false;
            if (!oldPass.Equals(curAcc.Password))
            {
                errStr = "Old Password is not match!";
                err = true;
            } else if (newPass == null || newPass.Trim().Equals(""))
            {
                errStr = "Please enter new Password!";
                err = true;
            }

            else if (newPass.Equals(oldPass))
            {
                errStr="New Password must be not equal Old Password! ";
                err = true;
            }
            else if (!newPass.Equals(confirm))
            {
                errStr="Confirm not match Password!";
                err = true;
            }

            if (err)
            {
                ViewBag.ERROR = errStr;
                return View("AccountPage");
            }
            //qua het cac validation

            SqlConnection con = DBServices.openConnection();
            SqlCommand command = null;
            string sql = "UPDATE Account " +
                        "SET Password = @Password" +
                        " WHERE UserID = @ID";
            command = new SqlCommand(sql, con);
            command.Parameters.Add("@ID", SqlDbType.NVarChar).Value = id;
            command.Parameters.Add("@Password", SqlDbType.NVarChar).Value = newPass;
            command.ExecuteNonQuery();
            con.Close();
            curAcc.Password = newPass;
            Session["User"] = curAcc;
            return RedirectToAction("Search", "Search");
        }
        public bool checkDuplicateID(string id)
        {
            Debug.WriteLine("check" + id);
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = "SELECT UserId FROM Account ";
            dr = command.ExecuteReader();
            while (dr.Read())
            {
                if (dr.GetString(0).Equals(id))
                {
                    con.Close();
                    return false;
                }
            }
            return true;
        }
    }
}