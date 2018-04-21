using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public abstract class BinaryExpression : AbstractExpression
    {
        protected AbstractExpression _expression1;
        protected AbstractExpression _expression2;

        public BinaryExpression(AbstractExpression expression1, AbstractExpression expression2)
        {
            _expression1 = expression1;
            _expression2 = expression2;
        }
    }
}
