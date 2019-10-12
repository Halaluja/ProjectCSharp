using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApp.Models.Motels
{
    public class MotelDTO
    {
        public string MotelID { get; set; }
        [Required(ErrorMessage = "Please enter the Motel's Name!")]
        public string MotelName { get; set; }
        [Required(ErrorMessage = "Please enter the Motel's Address!")]
        public string MotelAddress { get; set; }
        public string OnwerID { get; set; }
        public string Information { get; set; }
        public string Longitude { get; set; }
        public string Latitude { get; set; }
    }
}