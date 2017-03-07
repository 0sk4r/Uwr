class Node
  attr_accessor :val, :next
  @next = nil
  @prev = nil
  @val = nil

  def initialize(val)
    @val = val
  end

  def setPrev(node)
    @prev = node
  end

  def setNext(node)
    @next = node
  end

  def getNext()
    @next
  end

  def getPrev()
    @prev
  end

  def hasNext?()
    if @next
      true
    end
    false
  end

  def hasPrev?()
    if @prev
      true
    end
    false
  end

  def print()
    puts @val.to_s
  end

end

class DoubleLinkedList
  @len = nil

  def initialize(node)
    @root = node
    @len = 1
  end

  def insert(node)
    current = @root
    while current.hasNext?
      current = current.getNext
    end
    current.setNext(node)
    @len += 1
  end

  def len()
    @len
  end

  def swap(i, j)
    pom = i
    i.setPrev(j.getPrev)
    i.setNext(j.getNext)

    pom.setPrev(pom.getPrev)
    pom.setNext(pom.getNext)
  end

  def get(i)
    while(i!=0)
      pom = @root
      pom = pom.getNext
      i -= 1
    end
    pom
  end

  def print()
    current = @root
    while current != nil
      current.print
      current = current.getNext
    end
  end
end

lista = DoubleLinkedList.new(Node.new(1))
(2..10).each do |i|
  puts i
  lista.insert(Node.new(i))
end
lista.print()
