using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public abstract class AbstractExpression
    {
        public abstract bool interpret(Context context);
    }
}
