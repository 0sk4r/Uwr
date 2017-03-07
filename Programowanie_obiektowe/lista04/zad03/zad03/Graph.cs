using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad03
{
    interface Graph
    {
        void generateRandomGraph(int numberOfVertices, int numberOfEdges);
        int shortestPath(int v1, int v2);
        void addEdge(int v1, int v2);
        string toString();
        void print();
    }
}
