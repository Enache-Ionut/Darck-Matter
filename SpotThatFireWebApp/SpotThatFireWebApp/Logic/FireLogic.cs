using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpotThatFireWebApp.Logic
{
    public class FireLogic
    {
        /// <summary>
        /// Retrieve all fires around a given location
        /// </summary>
        /// <param name="data">Bucket of all fires to select from</param>
        /// <param name="lat">Latitude of given location</param>
        /// <param name="lon">Longitude of given location</param>
        /// <param name="radiusMeters">Radius, in meters, around location for which we want fires</param>
        /// <returns></returns>
        public static IEnumerable<SpotThatFireWebApp.Models.Fire> GetFires(IEnumerable<SpotThatFireWebApp.Models.Fire> data, 
                                                                           double lat, double lon, double radiusMeters)
        {
            return from f in data where GpsUtil.Distance(f.Latitude, f.Longitude, lat, lon) <= radiusMeters select f;
        }
    }
}