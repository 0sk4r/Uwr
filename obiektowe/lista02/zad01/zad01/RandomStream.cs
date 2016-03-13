using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad01
{
    class RandomStream : IntStream
    {
        Random rnd = new Random();

        public override int next()
        {
            return rnd.Next();
        }
    }
}
