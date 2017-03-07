using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    class Program
    {
        static void Main(string[] args)
        {
            Lista<int> mojaLista = new Lista<int>();
            Console.WriteLine(mojaLista.Pusta());
            mojaLista.AddFirst(3);
            mojaLista.AddFirst(2);
            mojaLista.AddFirst(1);
            mojaLista.AddLast(3);
            mojaLista.AddLast(2);
            mojaLista.AddLast(1);
            mojaLista.Wypisz();
            Console.WriteLine(mojaLista.Pusta());
            mojaLista.DelFirst();
            mojaLista.DelLast();
            mojaLista.Wypisz();
        }
    }
}
