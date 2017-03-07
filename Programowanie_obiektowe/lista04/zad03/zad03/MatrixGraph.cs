using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad03
{
    class MatrixGraph : Graph
    {

        private string[] Val;
        private bool[,] Connect;
        private Random rnd;
        private int V, E;

        public int getV()
        {
            return V;
        }

        public int getE()
        {
            return E;
        }


        private void Reset(int numberOfVertices)
        {
            rnd = new Random();
            V = numberOfVertices;
            E = 0;
            Val = new string[V];
            Connect = new bool[V, V];

            for (int i = 0; i < V; i++) for (int j = 0; j < V; j++) Connect[i, j] = false;
            for (int i = 0; i < V; i++) Val[i] = i.ToString();
        }

        public MatrixGraph(int numberOfVertices = 0)
        {
            Reset(numberOfVertices);
        }


        public void generateRandomGraph(int numberOfVertices, int numberOfEdges)
        {
            Reset(numberOfVertices);
            while (E < numberOfEdges) addRandomEdge();
        }

        public void addEdge(int v1, int v2)
        {
            Connect[v1, v2] = Connect[v2, v1] = true; E++;
        }

        public void addRandomEdge()
        {
            int a = rnd.Next(0, V), b = rnd.Next(0, V);
            if (Connect[a, b] == true) addRandomEdge();
            else { Connect[a, b] = Connect[b, a] = true; E++; }
        }



        public int shortestPath(int a, int b)
        {
            Queue<int> Q = new Queue<int>();
            bool[] Visited = new bool[V];
            int[] Distance = new int[V];
            string[] Path = new string[V];

            for (int i = 0; i < V; i++)
            {
                Visited[i] = false;
                Distance[i] = int.MaxValue;
                Path[i] = "";
            }

            Q.InsertToQueue(a);
            Visited[a] = true;
            Distance[a] = 0;
            Path[a] = a.ToString() + " ";

            while (Q.Count > 0)
            {
                int u = Q.TakeFromQueue();

                for (int i = 0; i < V; i++)
                {
                    if (Connect[u, i] == false) continue;

                    int v = i;

                    if (Visited[v] == false)
                    {
                        Q.InsertToQueue(v); Visited[v] = true;
                        Distance[v] = Distance[u] + 1;
                        Path[v] = Path[u] + "==> " + v.ToString() + " ";
                    }
                }
            }

            Console.WriteLine(Path[b]);
            return Distance[b];
        }


        public string toString()
        {
            string s = "";

            for (int i = 0; i < V; i++)
            {

                for (int j = 0; j < V; j++)
                {
                    if (Connect[i, j] == false) s += "0 ";
                    else s += "1 ";
                }

                s += "\n";
            }

            s += "\n"; return s;
        }

        public void print() { Console.WriteLine(toString()); }
    }
}
