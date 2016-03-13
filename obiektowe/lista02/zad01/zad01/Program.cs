using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad01
{
    class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("\n IntStream start");
            IntStream calkowite = new IntStream();

            for (int i = 0; i<10;i++)
            {
                Console.WriteLine(calkowite.next());
                Console.WriteLine(calkowite.eos());
            }

            Console.WriteLine("\n PrimeStream start");
            IntStream pierwsze = new PrimeStream();

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(pierwsze.next());
                Console.WriteLine(pierwsze.eos());
            }

            RandomStream losowa = new RandomStream();

            Console.WriteLine("\n RandomStream start");

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(losowa.next());
                Console.WriteLine(losowa.eos());
            }

            RandomWordStream slowo = new RandomWordStream();
            Console.WriteLine("\n RandomWordStream start");

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(slowo.next());
                Console.WriteLine(slowo.eos());
            }
        }
    }
}
