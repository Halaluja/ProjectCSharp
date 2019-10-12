using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApp.DataBase;
using WebApp.Models;
using WebApp.Models.User;

namespace WebApp.Controllers
{
    public class LoginController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult CheckLogin(Login user)
        {
            SqlConnection con = DBServices.openConnection();

            SqlCommand command;
            SqlDataReader dataReader;

            string sql;
            sql = "SELECT UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type" +
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
                Login tmp = new Login(UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type);
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
            Login tmp = GetAccount(id, type);
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
                tmp = new Login() { UserId = id, UserName = name, PhoneNumber = "", IDCardNumber = "", Address = "",  Password = "", Type = type};
            }
            Session["USER"] = tmp;
            return RedirectToAction("Search", "Search");
        }

        public Login GetAccount(string id, int type)
        {
            SqlConnection con = DBServices.openConnection();
            SqlCommand command = null;
            SqlDataReader dataReader = null;
            string sql = "SELECT UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type " +
                "FROM Account WHERE UserId = @USERID AND Type = @TYPE";
            command = new SqlCommand(sql, con);
            command.Parameters.Add("@USERID", SqlDbType.NVarChar).Value = id;
            command.Parameters.Add("@TYPE", SqlDbType.Int).Value = type;
            dataReader = command.ExecuteReader();
            if(dataReader.Read())
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
                Login tmp = new Login(UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type);
                return tmp;
            }
            return null;
        }
        public ActionResult Register()
        {
            return View();
        }
        public ActionResult Dangky(UserDTO dto)
        {
            if (!ModelState.IsValid)
            {
                return View("Register");
            }
            UserDAO dao = new UserDAO();
            dao.Register(dto);
            return View("Index");
        }
    }
}