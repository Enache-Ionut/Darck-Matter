using System.Collections.Generic;
using System.Web.Mvc;
using SpotThatFireWebApp.Models;
using DataLoaderCsv;

namespace SpotThatFireWebApp.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var fires = this.GetData();
            var locations = new List<Fire>();
            foreach (Fire fire in fires)
            {
                var f = new Fire()
                {
                    Latitude = fire.Latitude,
                    Longitude = fire.Longitude
                };
                locations.Add(f);
            }
            return View(locations);
        }
    
        #region Get Data

        private List<Fire> GetData()
        {
            List<Fire> fireList = new List<Fire>();

            var fires = CsvLoader.Load(@"c:\test\data.csv");
            foreach (var fire in fires)
            {
                fireList.Add(new Fire()
                {
                    Brightness = fire.Brightness,
                    BrightT31 = fire.BrightT31,
                    Confidence = fire.Confidence,
                    DayNight = fire.DayNight,
                    Frp = fire.Frp,
                    Latitude = fire.Latitude,
                    Longitude = fire.Longitude,
                    Satellite = fire.Satellite,
                    Scan = fire.Scan,
                    Time = fire.Time,
                    Track = fire.Track,
                    Version = fire.Version
                });
            }

            return fireList;
        }


        #endregion
    }
}