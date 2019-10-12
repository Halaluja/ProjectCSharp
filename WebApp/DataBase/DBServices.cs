using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApp.DataBase
{
    public static class DBServices
    {
        public static SqlConnection openConnection()
        {
            try
            {
                string connetionString;
                SqlConnection cnn;
                //connetionString = @"Data Source=SE130571;Initial Catalog=MotelRoomManagement;User ID=sa;Password=sa";

                connetionString = @"Data Source=projectcsharp.database.windows.net;Initial Catalog=MotelRoomManagement;User ID=sa123;Password=123456Sa";
                cnn = new SqlConnection(connetionString);
                cnn.Open();
                return cnn;
            }
            catch (Exception e)
            {
                Console.WriteLine("ERROR");
            }
            return null;
        }
    }
}