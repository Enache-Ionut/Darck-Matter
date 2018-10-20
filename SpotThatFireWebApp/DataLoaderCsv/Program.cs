using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic.FileIO;

namespace DataLoaderCsv
{
    class Program
    {
        static void Main(string[] args)
        {
            var data = CsvLoader.Load(@"c:\test\data.csv");
            int i = 0; i++;
        }
    }
}
