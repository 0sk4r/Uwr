using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Visitor
{
    class Program
    {
        public static void Main(string[] args)
        {
            Tree root = new TreeNode()
            {
                Left = new TreeNode()
                {
                    Left = new TreeLeaf() { Value = 1 },
                    Right = new TreeLeaf() { Value = 2 }
                },
                Right = new TreeLeaf() { Value = 3 }
            };

            DepthTreeVisitor visitor = new DepthTreeVisitor();
            visitor.Visit(root);
            Console.WriteLine("Głębokość drzewa to {0}", visitor.Depth);
            Console.ReadKey();
        }
    }
}
