using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad03
{
    class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("Listy sasiedztwa :\n");
            ListGraph G1 = new ListGraph(7);

            G1.addEdge(1, 2);
            G1.addEdge(2, 3);
            G1.addEdge(2, 4);
            G1.addEdge(2, 5);
            G1.addEdge(5, 6);

            G1.print();

            Console.WriteLine(G1.shortestPath(1, 6));
            Console.WriteLine("KONIEC\n");

            Console.WriteLine("Macierz za pomoca grafu :\n");
            MatrixGraph G2 = new MatrixGraph(6);

            G2.addEdge(0, 1);
            G2.addEdge(1, 2);
            G2.addEdge(1, 3);
            G2.addEdge(1, 4);
            G2.addEdge(4, 5);

            G2.print();

            Console.WriteLine(G2.shortestPath(0, 5));
            Console.WriteLine("KONIEC\n");


        }
    }
}
