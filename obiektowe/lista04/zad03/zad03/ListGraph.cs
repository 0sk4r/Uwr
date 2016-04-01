using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad03
{
        public class ListGraph : Graph
        {
            private List<int>[] L;
            private string[] Val;
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


            private void Reset(int numOfVert)
            {
                V = numOfVert; E = 0;
                Val = new string[V];
                L = new List<int>[V];

                for (int i = 0; i < V; i++) Val[i] = i.ToString();
                for (int i = 0; i < V; i++) L[i] = new List<int>();
            }

            public ListGraph(int numberOfVertices = 0)
            {
                rnd = new Random();
                Reset(numberOfVertices);
            }



            public void generateRandomGraph(int numberOfVertices, int numberOfEdges)
            {
                Reset(numberOfVertices);
                while (E < numberOfEdges) addRandomEdge();
            }

            public void addEdge(int v1, int v2)
            {
                L[v1].Add(v2); L[v2].Add(v1); E++;
            }

            public void addRandomEdge()
            {
                int a = rnd.Next(0, V); int b = rnd.Next(0, V);
                addEdge(a, b);
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

                Q.InsertToQueue(a); Visited[a] = true; Distance[a] = 0; Path[a] = a.ToString() + " ";

                while (Q.Count > 0)
                {
                    int u = Q.TakeFromQueue();

                    for (int i = 0; i < L[u].Count; i++)
                    {
                        int v = L[u][i];

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
                    s += i.ToString() + ": ";

                    for (int j = 0; j < L[i].Count; j++) s += L[i][j].ToString() + ", ";

                    s += "\n";
                }

                return s;
            }

            public void print() { Console.WriteLine(toString()); }
        }
}
