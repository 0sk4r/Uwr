using System;
using System.Collections.Generic;
using System.ComponentModel.Design.Serialization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    class Lista<T>
    {
        public Node<T> firstNode;
        public Node<T> lastNode;
        public int count;

        public Lista()
        {
            firstNode = null;
            lastNode = null;
            count = 0;
        }

        public Node<T> FirstNode
        {
            get { return firstNode; }
        }

        public Node<T> LastNode
        {
            get { return lastNode; }
        }

        public void AddFirst(T x)
        {
            if (firstNode == null)
            {
                firstNode = new Node<T>(x);
                lastNode = firstNode;
            }
            else
            {
                firstNode.prev = new Node<T>(x);
                firstNode.prev.next = firstNode;
                firstNode = firstNode.prev;
            }
            count++;
        }

        public void AddLast(T x)
        {
            if (firstNode == null)
            {
                firstNode = new Node<T>(x);
                lastNode = firstNode;
            }
            else
            {
                lastNode.next = new Node<T>(x);
                lastNode.next.prev = lastNode;
                lastNode = lastNode.next;
                lastNode.next = null;
            }
            count++;
        }

        public void DelFirst()
        {
            firstNode = firstNode.next;
            count--;
        }

        public void DelLast()
        {
            lastNode.prev.next = null;
            count--;
        }

        public void Wypisz()
        {
            var current = firstNode;
            while (current != null)
            {
                Console.WriteLine(current.Element);
                current = current.next;
            }
        }

        public bool Pusta()
        {
            return count == 0;
        }
    }
}