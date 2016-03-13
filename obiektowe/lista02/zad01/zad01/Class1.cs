using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad01
{
    public class IntStream
    {
        public int poprzedni;

        public virtual int next()
        {
            if (poprzedni == int.MaxValue) return -1;
            else
            {
                poprzedni++;
                return poprzedni;
            }
        }

        public bool eos()
        {
            return (poprzedni == int.MaxValue);
        }

        public void reset()
        {
            poprzedni = -1;
        }

        public IntStream()
        {
            reset();
        }
    }
}