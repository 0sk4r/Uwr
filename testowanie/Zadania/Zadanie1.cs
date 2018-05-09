using System;
using System.Collections.Generic;

namespace Zadania
{
    public class Zadanie1
    {
        public List<string> deleteFromList(string item, List<string> list){
            
            if(item == null){
                throw new ArgumentNullException("item", "Argument jest null");
            }
            else if (list == null){
                throw new ArgumentNullException("list", "Argument jest null");
            }

            list.Remove(item);

            return list;
        }
    }
}