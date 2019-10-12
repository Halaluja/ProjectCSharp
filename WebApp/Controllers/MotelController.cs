using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApp.Models;
using System.Diagnostics;
using System.Data.SqlClient;
using WebApp.DataBase;
using System.Data;

namespace WebApp.Controllers
{
    public class MotelController : Controller
    {
        // GET: Motel
        public ActionResult ViewMotel()
        {
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            List<Motel> MotelList = new List<Motel>();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = "SELECT ID,NAME,Address,Information,Longitude,Latitude FROM Motel WHERE UserID=@userID ";
            command.Parameters.Add("@userID", SqlDbType.NVarChar, 50).Value = ((Account)Session["USER"]).UserId;
            dr = command.ExecuteReader();
            while (dr.Read())
            {
                Motel tmp = new Motel();
                tmp.ID = dr.GetString(0);
                tmp.Name = dr.GetString(1);
                tmp.Address = dr.GetString(2);
                tmp.Information = dr.GetString(3);
                tmp.Longitude = float.Parse(dr.GetDouble(4).ToString());
                tmp.Latitude = float.Parse(dr.GetDouble(5).ToString());
                MotelList.Add(tmp);
            }
            ViewBag.MOTELLIST = MotelList;
            return View();
        }
        [HttpPost]
        public ActionResult InsertNewMotel(Motel dto)
        {
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            if (!ModelState.IsValid)
            {
                Debug.WriteLine("That Bai. sai du lieu");
                ViewBag.ID = getNewMotelID();
                return View("InsertMotel");
            }

            ViewBag.ID = dto.ID;
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = "INSERT INTO Motel(ID,Name,UserID,Address,Information,Longitude,Latitude,Internet,Electric,Water,ParkingPlace)" +
            "VALUES (@Id,@Name,@UserID,@Address,@Inforation,@Longitude,@Latitude,@Internet,@Electric,@Water,@ParkingPlace)";
            command.Parameters.Add("@Id", SqlDbType.VarChar, 10).Value = dto.ID;
            command.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = dto.Name;
            command.Parameters.Add("@UserID", SqlDbType.NVarChar, 50).Value = dto.UserId;
            command.Parameters.Add("@Address", SqlDbType.NVarChar, 200).Value = dto.Address;
            command.Parameters.Add("@Inforation", SqlDbType.NVarChar, 500).Value = dto.Information + "";
            command.Parameters.Add("@Longitude", SqlDbType.Float).Value = dto.Longitude;
            command.Parameters.Add("@Latitude", SqlDbType.Float).Value = dto.Latitude;
            command.Parameters.Add("@Internet", SqlDbType.NVarChar,100).Value = dto.Internet;
            command.Parameters.Add("@Electric", SqlDbType.NVarChar,100).Value = dto.Electric;
            command.Parameters.Add("@Water", SqlDbType.NVarChar, 100).Value = dto.Water;
            command.Parameters.Add("@ParkingPlace", SqlDbType.NVarChar, 100).Value = dto.ParkingPlace;
            int rs = command.ExecuteNonQuery();
            if (rs > 0)
            {
                con.Close();
                Debug.WriteLine("Thanh cong");
                return RedirectToAction("ViewMotel");
            }
            con.Close();
            Debug.WriteLine("That Bai");

            ViewBag.ID = getNewMotelID();
            return View("InsertMotel");
        }
        public ActionResult InsertPage()
        {
            ViewBag.ID = getNewMotelID();
            return View("InsertMotel");
        }
        public ActionResult ViewInfo(string MotelID)
        {
            return RedirectToAction("", "");
        }
        public ActionResult Update()
        {
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Update Motel set Information =@Info where  ID=@Id";
            command.Parameters.Add("@Info", SqlDbType.NVarChar, 500).Value = (string)Request["UpdateInformation"];
            command.Parameters.Add("@Id", SqlDbType.VarChar, 10).Value = Request["id"];
            command.ExecuteNonQuery();
            con.Close();
            return RedirectToAction("ViewMotel", "Motel");
        }public void RemoveAllRoom(String id)
        {
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Delete from Room where MotelID=@Id ";
            command.Parameters.Add("@Id", SqlDbType.VarChar, 10).Value = Request["id"];
            command.ExecuteNonQuery();
            con.Close();
        }
        public ActionResult Delete()
        {
            RemoveAllRoom(Request["id"]);
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Delete from Motel where ID=@Id ";
            command.Parameters.Add("@Id", SqlDbType.VarChar, 10).Value = Request["id"];
            command.ExecuteNonQuery();
            con.Close();
            return RedirectToAction("ViewMotel", "Motel");
        }
        public string getNewMotelID()
        {
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            var chars = "1234567890";
            var stringChars = new char[10];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }
            string s = new string(stringChars);
            //checkduplicate
            con = DBServices.openConnection();

            command.Connection = con;
            command.CommandText = "SELECT ID FROM Motel ";
            dr = command.ExecuteReader();
            while (dr.Read())
            {
                if (dr.GetString(0).Equals(s))
                {
                    con.Close();
                    s = getNewMotelID();
                }
            }

            return s;
        }
    }
}