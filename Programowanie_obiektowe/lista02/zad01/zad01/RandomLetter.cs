using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad01
{
    static class RandomLetter
    {
        static Random random = new Random();

        public static char Litera()
        {
            int index = random.Next(0, 26);
            char litera = (char)('a' + index);
            return litera;
        }
    }
}
