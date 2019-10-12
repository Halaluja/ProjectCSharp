using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApp.DataBase;
using WebApp.Models;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using System.Configuration;

namespace WebApp.Controllers
{
    public class RoomController : Controller
    {
        public ActionResult Index()
        {
            Session.Add("MotelId", Request["id"]);
            return RedirectToAction("ViewRoom","Room");
        }
        // GET: Room
        public ActionResult ViewRoom()
        {
            if(TempData["DuplicateMessage"] != null)
            {
                Debug.WriteLine("Duplicate");
                ViewBag.Duplicateid= TempData["Duplicateid"];
                ViewBag.DuplicateMessage = TempData["DuplicateMessage"].ToString();
            }
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            List<Rooms> listRoom=new List<Rooms>();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"SELECT  RoomID, Status, Price, NumberOfPeople,RoomName FROM Room where MotelID='" + Session["MotelId"] + "'";
            dr = command.ExecuteReader();
            while (dr.Read())
            {
                Rooms tmp = new Rooms();
                tmp.RoomId = dr.GetInt32(0);
                tmp.Status = dr.GetBoolean(1);
                tmp.Price = float.Parse(dr.GetDouble(2).ToString());
                tmp.NumberOfPeople = dr.GetInt32(3);
                tmp.RoomName = dr.GetString(4);
                tmp.MotelID = (string)Session["MotelId"];
                listRoom.Add(tmp);
            }
            con.Close();
            ViewBag.ROOMLIST= listRoom;
            return View("");
        }

    public ActionResult Delete()
     {
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Delete from Room where RoomId='"+Request["id"]+"'";
            command.ExecuteNonQuery();
            return RedirectToAction("ViewRoom", "Room");
        }
        public ActionResult InsertPage()
        {
            return View();
        }
        public ActionResult InsertNewRoom(Rooms dto)
        {
            Debug.WriteLine("session" + Session["MotelId"]);
            if (!ModelState.IsValid)
            {
                return View("InsertPage");
            }
            if (CheckDuplicateRoomName(dto.RoomName, dto.RoomId))
            {
                ViewBag.Duplicatename = "This Room already exist!";
                return View("InsertPage");
            }
            
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Insert Into Room(RoomName ,Status, Price,MotelID,NumberOfPeople ) values (@name,@status,@Price,@motelID,@numofpeople)";
            command.Parameters.Add("@name", System.Data.SqlDbType.NVarChar).Value = dto.RoomName;
           if (dto.Status )
            {
                command.Parameters.Add("@status", System.Data.SqlDbType.Bit).Value = 1;
            }else
            {
                command.Parameters.Add("@status", System.Data.SqlDbType.Bit).Value = 0;
            }
            command.Parameters.Add("@Price", System.Data.SqlDbType.Float).Value =dto.Price;
            command.Parameters.Add("@motelID", System.Data.SqlDbType.VarChar, 10).Value = Session["MotelId"];
            command.Parameters.Add("@numofpeople", System.Data.SqlDbType.Int).Value = dto.NumberOfPeople;

            if (command.ExecuteNonQuery()>0)
            {

                List<HttpPostedFileBase> listImage = new List<HttpPostedFileBase>();
                int roomid = getRoomID();
                string imageKey = Session["MotelId"].ToString() + "_" + roomid;
                for (int i = 0; i < Request.Files.Count; i++)
                {
                    HttpPostedFileBase filePosted = Request.Files[i];
                    if (filePosted != null && filePosted.ContentLength > 0)
                    {
                        string path = imageKey + "_" + filePosted.FileName;
                        InsertRoomImage(roomid, path);
                        listImage.Add(filePosted);
                    }
                }
                GetCloudBlobContainer(listImage, imageKey);
            }
            con.Close();
            return RedirectToAction("ViewRoom", "Room");
        }
        private int getRoomID()
        {
            int result = -1;
            SqlConnection con = new SqlConnection();
            
            con = DBServices.openConnection();
            string query = "SELECT Max([RoomID]) FROM[dbo].[Room]";
            SqlCommand command = new SqlCommand(query,con);
            SqlDataReader dr = command.ExecuteReader();
            if (dr.Read()) result = dr.GetInt32(0);
            con.Close();
            return result;
        }

        private void InsertRoomImage(int RoomID, string path)
        {
            SqlConnection con = new SqlConnection();
            con = DBServices.openConnection();
            string query = "INSERT INTO RoomImages(RoomID,Path) VALUES(@ID,@PATH)";
            SqlCommand command = new SqlCommand(query, con);
            command.Parameters.AddWithValue("@ID", RoomID);
            command.Parameters.AddWithValue("@PATH", path);
            command.ExecuteNonQuery();
            con.Close();

        }
        public ActionResult Update(Rooms room)
        {
            if (CheckDuplicateRoomName(room.RoomName,room.RoomId))
            {
                TempData["DuplicateMessage"] = "This Room already exist!";
                TempData["Duplicateid"] = room.RoomId;
                return RedirectToAction("ViewRoom","Room");
            }
            SqlConnection con = new SqlConnection();
            SqlCommand command = new SqlCommand();
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Update Room set RoomName=@name,Price=@price, Status=@status,NumberOfPeople=@numofpeople where  RoomId=@id";
            command.Parameters.Add("@name", System.Data.SqlDbType.NVarChar).Value = room.RoomName;
            if (room.Status)
            {
                command.Parameters.Add("@status", System.Data.SqlDbType.Bit).Value = 1;
            }
            else
            {
                command.Parameters.Add("@status", System.Data.SqlDbType.Bit).Value = 0;
            }
            command.Parameters.Add("@Price", System.Data.SqlDbType.Float).Value = room.Price;
            command.Parameters.Add("@numofpeople", System.Data.SqlDbType.Int).Value = room.NumberOfPeople;
            command.Parameters.Add("@id", System.Data.SqlDbType.Int).Value = room.RoomId;

            command.ExecuteNonQuery();
            con.Close();
            return RedirectToAction("ViewRoom", "Room");
        }
        public ActionResult getRoom(string id)
        {
            List<Rooms> list = new List<Rooms>();
            SqlConnection con = DBServices.openConnection();
            SqlCommand command = null;
            SqlDataReader dataReader = null;
            string sql = "SELECT RoomID, RoomName, MotelID, Status, Price, NumberOfPeople " +
                "FROM Room WHERE MotelID = @MOTELID";
            command = new SqlCommand(sql, con);
            command.Parameters.Add("@MOTELID", SqlDbType.VarChar).Value = id;
            dataReader = command.ExecuteReader();
            while (dataReader.Read())
            {
                string RoomName, MotelID;
                int RoomID;
                bool Status;
                float Price;
                int NumberOfPeople;
                RoomID = dataReader.GetInt32(0);
                RoomName = dataReader.GetString(1);
                MotelID = dataReader.GetString(2);
                Status = dataReader.GetBoolean(3);
                Price = float.Parse(dataReader.GetDouble(4).ToString());
                NumberOfPeople = dataReader.GetInt32(5);

                Rooms tmp = new Rooms {
                    MotelID = MotelID,
                    RoomName = RoomName,
                    RoomId = RoomID,
                    Price = Price,
                    Status = Status,
                    NumberOfPeople = NumberOfPeople
                };
                list.Add(tmp);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        public bool CheckDuplicateRoomName(string NameRoom,int RoomID) 
        {
            SqlConnection con = DBServices.openConnection();
            SqlCommand command = null;
            SqlDataReader dataReader = null;
            string sql = "SELECT RoomID " +
                "FROM Room WHERE MotelID = @MOTELID AND RoomName=@ROOMNAME";
            command = new SqlCommand(sql, con);
            command.Parameters.Add("@MOTELID", SqlDbType.VarChar).Value = Session["MotelId"];
            command.Parameters.Add("@ROOMNAME", SqlDbType.NVarChar).Value = NameRoom;
            dataReader = command.ExecuteReader();
            if (dataReader.Read())
            {
                if (dataReader.GetInt32(0).Equals(RoomID))
                {
                    con.Close();
                    return false;
                }
                con.Close();
                return true;
            }
            con.Close();
            return false;
        }

        public void GetCloudBlobContainer(List<HttpPostedFileBase> list, string key)
        {
            string conString = ConfigurationManager.ConnectionStrings["AzureStorage"].ConnectionString;
            string destContainer = ConfigurationManager.AppSettings["destContainer"];

            CloudStorageAccount sa = CloudStorageAccount.Parse(conString);
            CloudBlobClient bc = sa.CreateCloudBlobClient();
            CloudBlobContainer container = bc.GetContainerReference(destContainer); //Tạo new container
            container.CreateIfNotExists();

            BlobContainerPermissions per = container.GetPermissions();
            per.PublicAccess = BlobContainerPublicAccessType.Container;
            container.SetPermissions(per);



            foreach (var item in list)
            {
                key = key + "_" + item.FileName; //Tên của file trên azure
                UploadBlob(container, key, item);
            }
        }

        public void UploadBlob(CloudBlobContainer container, string key, HttpPostedFileBase fileName)
        {
            CloudBlockBlob b = container.GetBlockBlobReference(key);

            b.UploadFromStream(fileName.InputStream);

        }
    }
}