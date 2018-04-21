using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._1
{
    public enum LogType { None, Console, File };

    public class LoggerFactory
    {
        private static LoggerFactory _instance = null;

        private LoggerFactory()
        {
            // Nothing here.
        }

        public ILogger getLogger(LogType type, String parameters = null)
        {
            switch (type)
            {
                case LogType.Console: return new ConsoleLogger();
                case LogType.File: return new FileLogger(parameters);
                case LogType.None:
                default: return new NullLogger();
            }
        }

        public static LoggerFactory Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new LoggerFactory();
                }
                return _instance;
            }
        }
    }
}
