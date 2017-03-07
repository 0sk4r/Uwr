using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad04
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("\nLista zwykla :");

            leniwa lista = new leniwa();
            lista.wypisz();
            Console.WriteLine("51 element  " + lista.element(51));
            lista.wypisz();
            Console.WriteLine("54 element " + lista.element(54));
            lista.wypisz();
            Console.WriteLine("1 element  " + lista.element(1));
            lista.wypisz();
            Console.WriteLine("100 element listy to " + lista.element(100));
            lista.wypisz();

            Console.WriteLine("\nLista pierwsza :");

            Pierwsze lista2 = new Pierwsze();
            lista2.wypisz();
            Console.WriteLine("50 element  " + lista2.element(50));
            lista2.wypisz();
            Console.WriteLine("54 element  " + lista2.element(54));
            lista2.wypisz();
            Console.WriteLine("1 element  " + lista2.element(1));
            lista2.wypisz();
            Console.WriteLine("100 element  " + lista2.element(100));
            lista2.wypisz();
            Console.WriteLine("3 element  " + lista2.element(3));
            lista2.wypisz();
        }
    }
}
