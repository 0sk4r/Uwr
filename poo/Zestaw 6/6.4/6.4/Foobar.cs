using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace _6._4
{
    class Foobar : ExpressionVisitor
    {
        protected override Expression VisitBinary(BinaryExpression node)
        {
            Console.Write("(");

            this.Visit(node.Left);

            Console.Write(" {0} ", node.NodeType.ToString());

            this.Visit(node.Right);

            Console.Write(")");

            return node;
        }

        protected override Expression VisitConstant(ConstantExpression node)
        {
            Console.Write(node.Value);
            return node;
        }

        protected override Expression VisitParameter(ParameterExpression node)
        {
            Console.Write(node.Name);
            return node;
        }
    }
}
