using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Tree
{
    public abstract class TreeVisitor
    {
        public int CurrentDepth { get; set; }

        public abstract void VisitNode(TreeNode node);
        public abstract void VisitLeaf(TreeLeaf leaf);

    }
}
