using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._1
{
    class Program
    {
        static void Main(string[] args)
        {
            ILogger logger1 = LoggerFactory.Instance.getLogger(LogType.Console);
            ILogger logger2 = LoggerFactory.Instance.getLogger(LogType.File, "log.txt");
            ILogger logger3 = LoggerFactory.Instance.getLogger(LogType.None);

            logger1.log("Logging to console.");
            logger2.log("Logging to file.");
            logger3.log("Ain't loggin'.");

            Console.ReadKey();
        }
    }
}
