using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public abstract class UnaryExpression : AbstractExpression
    {
        protected AbstractExpression _expression;

        public UnaryExpression(AbstractExpression expression)
        {
            _expression = expression;
        }
    }
}
