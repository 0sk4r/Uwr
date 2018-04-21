using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Visitor
{
    public class DepthTreeVisitor : TreeVisitor
    {
        public int Depth { get; set; }
        public int CurrentDepth { get; set; }

        public override void VisitNode(TreeNode node)
        {
            CurrentDepth++;
            base.VisitNode(node);
            CurrentDepth--;
        }
        public override void VisitLeaf(TreeLeaf leaf)
        {
            if (CurrentDepth > Depth)
            {
                Depth = CurrentDepth;
            }
            base.VisitLeaf(leaf);
        }
    }
}
