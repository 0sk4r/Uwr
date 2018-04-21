using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._1
{
    public class ConsoleLogger : ILogger
    {
        public void log(String message)
        {
            Console.WriteLine(message);
        }
    }
}
