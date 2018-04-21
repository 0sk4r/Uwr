using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._3_Visitor
{
    public class TreeNode : Tree
    {
        public Tree Left { get; set; }
        public Tree Right { get; set; }
    }
}
