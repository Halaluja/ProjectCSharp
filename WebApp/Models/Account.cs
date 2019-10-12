using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApp.Models
{
    public class Account
    {
        //UserId, UserName, PhoneNumber, IDCardNumber, Address, Password, Type
        [Required(ErrorMessage = "Required!")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "It's must be form 4-50 character!")]
        public string UserId { get; set; }
        [Required(ErrorMessage = "Required!")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "It's must be form 4-50 character!")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Required!")]
        [RegularExpression(@"^([0-9]{10})$", ErrorMessage = "Invalid Phone Number.")]
        [Display(Name = "PhoneNumber")]
        public string PhoneNumber { get; set; }

        [Required(ErrorMessage = "Required!")]
        [DataType(DataType.CreditCard, ErrorMessage = "Please enter correct social Id!")]
        public string IDCardNumber { get; set; }

        [Required(ErrorMessage = "Required!")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Required!")]
        /*[DataType(DataType.Password, ErrorMessage = "Please enter correct password!")]*/
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Required!")]
        [RegularExpression(@"^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-‌​]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$", ErrorMessage = "Email is not valid")]
        public string Email { get; set; }
        public int Type { get; set; }

        public Account(string UserId, string UserName, string PhoneNumber, 
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
        public Account()
        {

        }
    }
}