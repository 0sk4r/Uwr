using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    public class Node<T>
    {
        public Node<T> next;
        public Node<T> prev;
        T element;

        public T Element
        {
            get { return element; }
            set { element = value; }
        }

        public Node(T element)

        {
            this.element = element;
            this.next = null;
            this.prev = null;
        }

       
    }
}