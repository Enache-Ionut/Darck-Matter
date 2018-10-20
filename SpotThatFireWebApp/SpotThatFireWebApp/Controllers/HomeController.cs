using DataLoaderCsv;
using SpotThatFireWebApp.Models;
using System;
using System.Collections.Generic;
using System.Net;
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

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }


        #region UpdateData


        public void UpdateData()
        {
            var startTimeSpan = TimeSpan.Zero;
            var periodTimeSpan = TimeSpan.FromSeconds(30);

            timer = new System.Threading.Timer((e) =>
            {
                string remoteUri = "https://firms.modaps.eosdis.nasa.gov/data/active_fire/c6/csv/MODIS_C6_Global_24h.csv";
                string fileName = @"C:\WorkSpace\Work\Github\DarkMatter\data.csv", myStringWebResource = null;

                // Create a new WebClient instance.
                using (WebClient myWebClient = new WebClient())
                {
                    myStringWebResource = remoteUri;
                    // Download the Web resource and save it into the current filesystem folder.
                    myWebClient.DownloadFile(myStringWebResource, fileName);
                }

                fireList = GetData();

            }, null, startTimeSpan, periodTimeSpan);
        }


        #endregion



        #region Get Data


        private List<Fire> GetData()
        {
            fireList.Clear();

            var fires = CsvLoader.Load(@"C:\WorkSpace\Work\Github\DarkMatter\SpotThatFireWebApp\data.csv");
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