using DataLoaderCsv;
using SpotThatFireWebApp.Models;
using System;
using System.Collections.Generic;
using System.Net;
using System.Threading;
using System.Web.Mvc;

namespace SpotThatFireWebApp.Controllers
{
    public class HomeController : Controller
    {
        #region Members

        private List<Fire> fireList = new List<Fire>();
        private static System.Threading.Timer timer;

        #endregion

        public ActionResult Index()
        {
            UpdateData();

            var fires = fireList;
            var locations = new List<Fire>();
            for(int i= 0; i < 10000; i++)
            //foreach (Fire fire in fires)
            {
                var f = new Fire()
                {
                    Latitude = fires[i].Latitude,
                    Longitude = fires[i].Longitude
                };
                locations.Add(f);
            }
            return View(locations);
        }

        public ActionResult SaveFireLocation(Location location)
        {
            
            return RedirectToAction("Index");
        }

        #region UpdateData


        public void UpdateData()
        {
            var startTimeSpan = TimeSpan.Zero;
            var periodTimeSpan = TimeSpan.FromSeconds(30);

            Update();

            timer = new System.Threading.Timer((e) =>
            {
                Update();
            }, null, startTimeSpan, periodTimeSpan);
        }


        public void Update()
        {
            string remoteUri = "https://firms.modaps.eosdis.nasa.gov/data/active_fire/c6/csv/MODIS_C6_Global_24h.csv";
            string fileName = @"C:\WorkSpace\Programs\Git\DarkMatter\data.csv", myStringWebResource = null;

            // Create a new WebClient instance.
            using (WebClient myWebClient = new WebClient())
            {
                myStringWebResource = remoteUri;
                // Download the Web resource and save it into the current filesystem folder.
                myWebClient.DownloadFile(myStringWebResource, fileName);
            }

            fireList = GetData();
        }


        #endregion



        #region Get Data


        private List<Fire> GetData()
        {
            fireList.Clear();

            var fires = CsvLoader.Load(@"C:\WorkSpace\Programs\Git\DarkMatter\data.csv");
            foreach (var fire in fires)
            {
                if (fire.Confidence < 50)
                    continue;
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