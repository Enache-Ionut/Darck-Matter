using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpotThatFireWebApp.Models
{
    public class Fire
    {
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public double Brightness { get; set; }
        public double Scan { get; set; }
        public double Track { get; set; }
        public DateTime Time { get; set; }
        public string Satellite { get; set; }
        public double Confidence { get; set; }
        public string Version { get; set; }
        public double BrightT31 { get; set; }
        public double Frp { get; set; }
        public string DayNight { get; set; }
    }
}