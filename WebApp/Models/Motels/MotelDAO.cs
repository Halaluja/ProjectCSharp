using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using WebApp.DataBase;

namespace WebApp.Models.Motels
{
    public class MotelDAO
    {
        List<MotelDTO> MotelList;
        public List<MotelDTO> GetMotelList()
        {
            return this.MotelList;
        }
        SqlConnection con = new SqlConnection();
        SqlCommand command = new SqlCommand();
        SqlDataReader dr;
        public string InsertMotel(MotelDTO dto)
        {

            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = "INSERT INTO Motel(ID,Name,UserID,Address,Information,Longitude,Latitude) " +
            "VALUES (@Id,@Name,@UserID,@Address,@Inforation,@Longitude,@Latitude)";
            command.Parameters.Add("@Id", SqlDbType.VarChar, 10).Value = dto.MotelID;
            command.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = dto.MotelName;
            command.Parameters.Add("@UserID", SqlDbType.NVarChar, 50).Value = dto.OnwerID;
            command.Parameters.Add("@Address", SqlDbType.NVarChar, 200).Value = dto.MotelAddress;
            command.Parameters.Add("@Inforation", SqlDbType.NVarChar, 500).Value = dto.Information+"";
            command.Parameters.Add("@Longitude", SqlDbType.NVarChar, 500).Value = dto.Longitude;
            command.Parameters.Add("@Latitude", SqlDbType.NVarChar, 500).Value = dto.Latitude;
            int rs = command.ExecuteNonQuery();
            if (rs > 0)
            {
                con.Close();
                return "success";
            }
            con.Close();
            return "fail";
        }
        public void getAllMotel(string userID)
        {
            con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = "SELECT ID,NAME,Address,Information,Longitude,Latitude FROM Motel WHERE UserID=@userID ";
            command.Parameters.Add("@userID", SqlDbType.NVarChar, 50).Value = userID;
            dr = command.ExecuteReader();
            while (dr.Read())
            {
                if (MotelList == null)
                {
                    MotelList = new List<MotelDTO>();
                }
                MotelDTO tmp = new MotelDTO();
                tmp.MotelID = dr.GetString(0);
                tmp.MotelName = dr.GetString(1);
                tmp.MotelAddress = dr.GetString(2);
                tmp.Information = dr.GetString(3);
                tmp.Longitude = dr.GetString(4);
                tmp.Latitude = dr.GetString(5);
                MotelList.Add(tmp);
            }
        }
        public string getNewMotelID()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
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
        public void deleteMotel(string Id)
        {
            SqlConnection con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Delete from Motel where ID='"+Id+"' ";
            command.ExecuteNonQuery();
            con.Close();
            
        }
        public void updateMotel(string Id,string Information)
        {
            SqlConnection con = DBServices.openConnection();
            command.Connection = con;
            command.CommandText = @"Update Motel set Information =@Info where  ID='" + Id + "'";
            command.Parameters.Add("@Info", SqlDbType.NVarChar, 500).Value = (string)Information;
            command.ExecuteNonQuery();
            con.Close();

        }
    }
}