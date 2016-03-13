using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad04
{
    class leniwa
    {
        public int rozmiar;
        public List<int> lista;
        public Random losowa;

        protected virtual int kolejnaLiczba(int n)
        {
            return losowa.Next();
        }

        public int size()
        {
            return rozmiar;
        }

        public int element(int n)
        {
            if (n < rozmiar) return lista[n];
            else
            {
                rozmiar = n;

                if (lista.Count == 0) lista.Add(0);

                for (int i = lista.Count; i < n; i++)
                {
                    lista.Add(kolejnaLiczba(lista[i]));
                }

                return lista[n];
            }
        }

        public void wypisz()
        {
            Console.WriteLine("Rozmiar listy to " + rozmiar);
        }

        public leniwa()
        {
            rozmiar = 0;
            lista = new List<int>();
            losowa = new Random();
        }
    }
}
