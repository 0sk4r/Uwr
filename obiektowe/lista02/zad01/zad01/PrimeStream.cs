using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad01
{
    public class PrimeStream : IntStream
    {

        public bool czypierwsza(int n)
        {
            if (n < 2) return false;
            
            for (int i = 2; i<= Math.Sqrt(n) && i < int.MaxValue; i++)
            {
                if (i == int.MaxValue)
                {
                    poprzedni = int.MaxValue;
                    return false;
                }

                if (n % i == 0) return false;
            }
            return true;
        }

        public override int next()
        {
            if (poprzedni == int.MaxValue) return -1;
            poprzedni++;

            while (!czypierwsza(poprzedni) && poprzedni < int.MaxValue) poprzedni++;

            return poprzedni;

        }



    }
}
