using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.Models
{
    public class Login
    {
        //UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string PhoneNumber { get; set; }
        public string IDCardNumber { get; set; }
        public string Address { get; set; }
        public string Password { get; set; }
        public int Type { get; set; }
        public Login(string UserId, string UserName, string PhoneNumber, 
            string IDCardNumber, string Address, string Password, int Type)
        {
            this.UserId = UserId;
            this.UserName = UserName;
            this.PhoneNumber = PhoneNumber;
            this.IDCardNumber = IDCardNumber;
            this.Address = Address;
            this.Password = Password;
            this.Type = Type;
        }
        public Login()
        {

        }
    }
}