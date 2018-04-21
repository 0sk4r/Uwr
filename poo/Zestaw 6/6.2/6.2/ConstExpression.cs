using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public class ConstExpression : AbstractExpression
    {
        private bool _value;

        public ConstExpression(bool value)
        {
            _value = value;
        }

        public override bool interpret(Context context)
        {
            return _value;
        }   
    }
}
