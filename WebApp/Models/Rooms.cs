using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApp.Models
{
    public class Rooms
    {
        public int RoomId { get; set; }
        [Required(ErrorMessage = "Please enter Room's name!")]

        public string RoomName { get; set; }
        public string MotelID { get; set; }
        [Required(ErrorMessage = "Please enter Price!")]
       // [Range(0, 999999999.9, ErrorMessage = "Invalid Price (Price>=0)")]
        public float Price { get; set; }
        public bool Status { get; set; }
        public int NumberOfPeople { get; set; }
    }
}