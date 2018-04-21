using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public class VariableExpression : AbstractExpression
    {
        private string _name;

        public VariableExpression(string name)
        {
            _name = name;
        }

        public override bool interpret(Context context)
        {
            return context.getValue(_name);
        }
    }
}
