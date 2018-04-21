using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._1
{
    public class FileLogger : ILogger
    {
        private string _fileName;

        public FileLogger(string fileName)
        {
            _fileName = fileName;
        }

        public void log(string message)
        {
            using (StreamWriter log = new StreamWriter(_fileName, true))
            {
                log.WriteLine(message);
            }
        }
    }
}
