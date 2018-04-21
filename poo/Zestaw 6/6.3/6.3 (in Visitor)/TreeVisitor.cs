using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Visitor
{
    public abstract class TreeVisitor
    {
        // ta metoda nie jest potrzebna ale ułatwia korzystanie z Visitora
        public void Visit(Tree tree)
        {
            if (tree is TreeNode)
                this.VisitNode((TreeNode)tree);
            if (tree is TreeLeaf)
                this.VisitLeaf((TreeLeaf)tree);
        }
        public virtual void VisitNode(TreeNode node)
        {
            // tu wiedza o odwiedzaniu struktury
            if (node != null)
            {
                this.Visit(node.Left);
                this.Visit(node.Right);
            }
        }
        public virtual void VisitLeaf(TreeLeaf leaf)
        {
        }
    }
}
