using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace _6._4
{
    class Program
    {
        static void Main(string[] args)
        {
            Expression<Func<int, int, int, double>> someExpr = (x, y, z) => (x * x + y * z) / 3.0;

            var myVisitor = new Foobar();
            myVisitor.Visit(someExpr.Body);

            Console.ReadKey();
        }
    }
}
