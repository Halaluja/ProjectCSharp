using System;
using System.Collections.Generic;
using System.Web.Mvc;
using WebApp.Models;
using WebApp.DataBase;
using System.Data.SqlClient;
using System.Data;

namespace WebApp.Controllers
{
    public class SearchController : Controller
    {
        // GET: Search
        public ActionResult Search()
        {
            return View();
        }

        /*public ActionResult GetAllMotel()
        {
            List<Motel> list = new List<Motel>();
            SqlConnection con = DBServices.openConnection();
            string query = "SELECT ID, Name, UserID, Address, Information, Longitude, Latitude" +
                " FROM tbl_MotelRoom";
            SqlCommand command = new SqlCommand(query, con);
            SqlDataReader data = command.ExecuteReader();
            while(data.Read())
            {
                string ID = "", Name = "", UserID = "", Address = "", Information = "";
                float Longitude;
                float Latitude;
                ID = data.GetString(0);
                Name = data.GetString(1);
                UserID = data.GetString(2);
                if (data["Address"] != DBNull.Value)
                {
                    Address = data.GetString(3);
                }
                if (data["Information"] != DBNull.Value)
                {
                    Information = data.GetString(4);
                }
                Longitude = data.GetFloat(5);
                Latitude = data.GetFloat(6);
                Motel motel = new Motel(ID, Name, UserID, Address, Information, Longitude, Latitude);
                list.Add(motel);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }*/

        /*public ActionResult GetMotelPaging(int previous)
        {
            List<Motel> list = new List<Motel>();
            int next = previous + 5;
            SqlConnection con = DBServices.openConnection();
            string query = "SELECT TOP " + next +
                " ID, Name, UserID, Address, Information, Longitude, Latitude" +
                " FROM tbl_MotelRoom " +
                "EXCEPT SELECT TOP " + previous +
                " ID, Name, UserID, Address, Information, Longitude, Latitude" +
                " FROM tbl_MotelRoom";
            SqlCommand command = new SqlCommand(query, con);
            //command.Parameters.Add("@NEXT", SqlDbType.Int).Value = next;
            //command.Parameters.Add("@PREVIOUS", SqlDbType.Int).Value = previous;
            SqlDataReader data = command.ExecuteReader();
            while (data.Read())
            {
                string ID = "", Name = "", UserID = "", Address = "", Information = "";
                float Longitude;
                float Latitude;
                ID = data.GetString(0);
                Name = data.GetString(1);
                UserID = data.GetString(2);
                if (data["Address"] != DBNull.Value)
                {
                    Address = data.GetString(3);
                }
                if (data["Information"] != DBNull.Value)
                {
                    Information = data.GetString(4);
                }
                Longitude = data.GetFloat(5);
                Latitude = data.GetFloat(6);
                Motel motel = new Motel(ID, Name, UserID, Address, Information, Longitude, Latitude);
                list.Add(motel);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }*/

        public ActionResult GetMotelByPosition(float lat, float lng)
        {
            List<Motel> list = new List<Motel>();

            SqlConnection con = DBServices.openConnection();
            string query = "SELECT ID, Name, UserID, Address, Information, Longitude, Latitude, " +
                "Internet, Electric, Water, ParkingPlace " +
                "FROM Motel WHERE SQRT(SQUARE(@LNG - Longitude) + SQUARE(@LAT - Latitude)) <= 0.0117";
            SqlCommand command = new SqlCommand(query, con);
            command.Parameters.Add("@LNG", SqlDbType.Float).Value = lng;
            command.Parameters.Add("@LAT", SqlDbType.Float).Value = lat;
            SqlDataReader data = command.ExecuteReader();
            while (data.Read())
            {
                string ID = "", Name = "", UserID = "", Address = "", Information = "";
                string Internet = "", Electric = "", Water = "", ParkingPlace = "";
                float Longitude;
                float Latitude;
                ID = data.GetString(0);
                Name = data.GetString(1);
                UserID = data.GetString(2);
                if (data["Address"] != DBNull.Value)
                {
                    Address = data.GetString(3);
                }
                if (data["Information"] != DBNull.Value)
                {
                    Information = data.GetString(4);
                }
                if (data["Internet"] != DBNull.Value)
                {
                    Internet = data.GetString(7);
                }
                if (data["Electric"] != DBNull.Value)
                {
                    Electric = data.GetString(8);
                }
                if (data["Water"] != DBNull.Value)
                {
                    Water = data.GetString(9);
                }
                if (data["ParkingPlace"] != DBNull.Value)
                {
                    ParkingPlace = data.GetString(10);
                }
                Longitude = float.Parse(data["Longitude"].ToString());
                Latitude = float.Parse(data["Latitude"].ToString());
                Motel motel = new Motel(ID, Name, UserID, Address, Information, Longitude, Latitude, Internet, Electric, Water, ParkingPlace);
                list.Add(motel);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }
    }

}