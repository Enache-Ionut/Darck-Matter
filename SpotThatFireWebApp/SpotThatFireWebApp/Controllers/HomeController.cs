using DataLoaderCsv;
using SpotThatFireWebApp.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace SpotThatFireWebApp.Controllers
{
    public class HomeController : Controller
    {
        #region Members

        private static List<Fire> fireRaportedByAuthorities = new List<Fire>();
        private static List<Fire> fireList = new List<Fire>();
        private static System.Threading.Timer timer;

        #endregion

        public ActionResult Index()
        {
            UpdateData();


            var fires = fireList;
            var locations = new List<Fire>();

            locations.AddRange(fireRaportedByAuthorities);
            locations.AddRange(GetLocation(fireList));

            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(locations);

            using (var writer = new StreamWriter(@"C:\inetpub\wwwroot\darkmatter.json"))
            {
                writer.Write(json);
            }

            return View(locations);
        }

        public ActionResult SaveFireLocation(Location location)
        {
            fireRaportedByAuthorities.Add(new Fire()
            {
                Latitude = location.Latitude,
                Longitude = location.Longitude,
                Confidence = 100
            });
            return RedirectToAction("Index");
        }

        #region UpdateData


        public List<Fire> GetLocation(List<Fire> fires)
        {
            var locations = new List<Fire>();
            var lenght = fires.Count > 9000 ? 9000 : fires.Count;
            for (int i = 0; i < lenght; i++)
            {
                var f = new Fire()
                {
                    Latitude = fires[i].Latitude,
                    Longitude = fires[i].Longitude
                };
                locations.Add(f);
            }

            return locations;
        }


        public void UpdateData()
        {
            var startTimeSpan = TimeSpan.Zero;
            var periodTimeSpan = TimeSpan.FromHours(1);

            Update();

            timer = new System.Threading.Timer((e) =>
            {
                Update();
            }, null, startTimeSpan, periodTimeSpan);
        }


        public void Update()
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
        }


        #endregion



        #region Get Data


        private List<Fire> GetData()
        {
            fireList.Clear();

            var fires = CsvLoader.Load(@"C:\WorkSpace\Work\Github\DarkMatter\data.csv");
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