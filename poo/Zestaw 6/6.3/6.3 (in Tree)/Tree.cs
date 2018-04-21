using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Tree
{
    public abstract class Tree
    {
        public virtual void Accept(TreeVisitor visitor)
        {
        }
    }
}
