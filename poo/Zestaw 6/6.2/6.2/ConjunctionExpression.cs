using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public class ConjunctionExpression : BinaryExpression
    {
        public ConjunctionExpression(AbstractExpression expression1, AbstractExpression expression2)
            : base(expression1, expression2)
        {

        }

        public override bool interpret(Context context)
        {
            return _expression1.interpret(context) && _expression2.interpret(context);
        }
    }
}
