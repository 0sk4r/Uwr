using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Tree
{
    public class TreeLeaf : Tree
    {
        public int Value { get; set; }
        public override void Accept(TreeVisitor visitor)
        {
            visitor.VisitLeaf(this);
        }
    }
}
