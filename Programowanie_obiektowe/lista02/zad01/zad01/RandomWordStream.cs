using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad01
{
    public class RandomWordStream : PrimeStream
    {
        
        public new string next()
        {
            if (poprzedni == int.MaxValue) return "";
            poprzedni++;

            while (!czypierwsza(poprzedni) && poprzedni < int.MaxValue) poprzedni++;
            if (poprzedni == int.MaxValue) return "";
            else
            {
                string napis = "";
                    for (int i =0; i<poprzedni; i++)
                {

                    napis += RandomLetter.Litera();
                }
                return napis;
            } 
        }

    }
}
