using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Tree
{
    public class TreeNode : Tree
    {
        public Tree Left { get; set; }
        public Tree Right { get; set; }

        public override void Accept(TreeVisitor visitor)
        {
            visitor.VisitNode(this);
            if (Left != null)
            {
                visitor.CurrentDepth++;
                Left.Accept(visitor);
                visitor.CurrentDepth--;
            }
            if (Right != null)
            {
                visitor.CurrentDepth++;
                Right.Accept(visitor);
                visitor.CurrentDepth--;
            }
        }
    }
}
