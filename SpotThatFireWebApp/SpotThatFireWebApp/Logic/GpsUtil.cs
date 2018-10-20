using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpotThatFireWebApp
{
    /// <summary>
    /// Gets distance, in meters, between two GPS points (latitude-longitude)
    /// Math source: https://www.movable-type.co.uk/scripts/latlong.html
    /// </summary>
    public class GpsUtil
    {
        public static double Distance(double lat1, double lon1, double lat2, double lon2)
        {
            var R = 6371e3; // metres
            var φ1 = ToRadians(lat1);
            var φ2 = ToRadians(lat2);
            var Δφ = ToRadians(lat2 - lat1);
            var Δλ = ToRadians(lon2 - lon1);

            var a = Math.Sin(Δφ / 2) * Math.Sin(Δφ / 2) +
                    Math.Cos(φ1) * Math.Cos(φ2) *
                    Math.Sin(Δλ / 2) * Math.Sin(Δλ / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));

            var d = R * c;

            return d;
        }

        public static bool IsSameLocation(double lat1, double lon1, double lat2, double lon2)
        {
            return Distance(lat1, lon1, lat2, lon2) < 100;
        }

        private static double ToRadians(double degrees)
        {
            return degrees * Math.PI / 180;
        }
    }
}