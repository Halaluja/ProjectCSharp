using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApp.Models
{
    public class Motel
    {
        public string ID { get; set; }


        [Required(ErrorMessage = "Please enter the Motel's Name!")]
        public string Name { get; set; }


        public string UserId { get; set; }


        [Required(ErrorMessage = "Please enter the Motel's Address!")]
        public string Address { get; set; }



        public string Information { get; set; }
        public float Longitude { get; set; }
        public float Latitude { get; set; }



        //[Required(ErrorMessage = "Please enter the Motel's Internet price!")]
        //[Range(0, 999999999.9, ErrorMessage = "Invalid Price (Price>=0)")]
        public string Internet { get; set; }


        //[Required(ErrorMessage = "Please enter the Motel's Electric price!")]
        //[Range(0, 999999999.9, ErrorMessage = "Invalid Price (Price>=0)")]
        public string Electric { get; set; }


        //[Required(ErrorMessage = "Please enter the Motel's Water price!")]
        //[Range(0, 999999999.9, ErrorMessage = "Invalid Price (Price>=0)")]
        public string Water { get; set; }


        //[Required(ErrorMessage = "Please enter the Motel's ParkingPlace price!")]
        //[Range(0, 999999999.9, ErrorMessage = "Invalid Price (Price>=0)")]
        public string ParkingPlace { get; set; }
        public Motel()
        {

        }
        public Motel(string ID, string Name, string UserId, string Address,
            string Information, float Longitude, float Latitude,
            string Internet, string Electric, string Water, string ParkingPlace
            )
        {
            this.ID = ID;
            this.Name = Name;
            this.UserId = UserId;
            this.Address = Address;
            this.Information = Information;
            this.Longitude = Longitude;
            this.Latitude = Latitude;
            this.Internet = Internet;
            this.Electric = Electric;
            this.Water = Water;
            this.ParkingPlace = ParkingPlace;
        }
    }
}