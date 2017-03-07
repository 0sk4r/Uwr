using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad04
{
    class Pierwsze : leniwa
    {
        private bool is_prime(int n)
        {
            if (n < 2) return false;

            for (int i = 2; i <= Math.Sqrt(n); i++)
            {
                if (n % i == 0) return false;
            }

            return true;
        }

        protected override int kolejnaLiczba(int n)
        {
            n++;
            while (!is_prime(n)) n++;
            return n;
        }
    }
}
