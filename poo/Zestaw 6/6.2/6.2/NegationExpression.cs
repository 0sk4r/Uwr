using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public class NegationExpression : UnaryExpression
    {
        public NegationExpression(AbstractExpression expression)
            : base(expression)
        {

        }

        public override bool interpret(Context context)
        {
            return !_expression.interpret(context);
        }
    }
}
