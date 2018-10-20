using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SpotThatFireWebApp.Models;
using Microsoft.VisualBasic.FileIO;

namespace DataLoaderCsv
{
    enum CsvFields : int
    {
        Latitude = 0,
        Longitude,
        Brightness,
        Scan,
        Track,
        Acq_date,
        Acq_time,
        Satellite,
        Confidence,
        Version,
        Bright_t31,
        Frp,
        Daynight
    }

    class CsvLoader
    {
        public static IEnumerable<SpotThatFireWebApp.Models.Fire> Load(string csvLocation)
        {
            List<SpotThatFireWebApp.Models.Fire> retList = new List<SpotThatFireWebApp.Models.Fire>();

            TextFieldParser parser = new TextFieldParser(csvLocation);
            parser.TextFieldType = FieldType.Delimited;
            parser.SetDelimiters(",");
            /*
             * latitude,longitude,brightness,scan,track,acq_date,acq_time,satellite,confidence,version,bright_t31,frp,daynight
               0        1         2          3    4     5        6        7         8          9       10         11  12
             */
            int i = 0;
            while (!parser.EndOfData)
            {
                string[] fields = parser.ReadFields();
                if (i++ < 2)
                    continue; //somehow two passes for header??

                string acqDate = fields[(int)CsvFields.Acq_date].Replace("-", "/");
                string acqTime = fields[(int)CsvFields.Acq_time].Insert(2, ":");

                SpotThatFireWebApp.Models.Fire fire = new SpotThatFireWebApp.Models.Fire();
                fire.Latitude = Convert.ToDouble(fields[(int)CsvFields.Latitude]);
                fire.Longitude = Convert.ToDouble(fields[(int)CsvFields.Longitude]);
                fire.Brightness = Convert.ToDouble(fields[(int)CsvFields.Brightness]);
                fire.Scan = Convert.ToDouble(fields[(int)CsvFields.Scan]);
                fire.Track = Convert.ToDouble(fields[(int)CsvFields.Track]);
                fire.Time = DateTime.Parse(acqDate + " " + acqTime);
                fire.Satellite = fields[(int)CsvFields.Satellite];
                fire.Confidence = Convert.ToDouble(fields[(int)CsvFields.Confidence]);
                fire.Version = fields[(int)CsvFields.Version];
                fire.BrightT31 = Convert.ToDouble(fields[(int)CsvFields.Bright_t31]);
                fire.Frp = Convert.ToDouble(fields[(int)CsvFields.Frp]);
                fire.DayNight = fields[(int)CsvFields.Daynight];

                retList.Add(fire);
            }

            return retList;
        }
    }
}
