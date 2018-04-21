using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6._2
{
    public class Context
    {
        private Dictionary<string, bool> _variables = new Dictionary<string, bool>();

        public bool getValue(string variableName)
        {
            if(!_variables.ContainsKey(variableName))
            {
                throw new ArgumentException("Invalid variable name");
            }

            return _variables[variableName];
        }

        public void setValue(string variableName, bool value)
        {
            _variables.Add(variableName, value);
        }
    }
}
