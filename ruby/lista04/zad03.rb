class Element
  include Comparable

  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @rigt = nil
  end

  def <=>(another)
    value <=> another
  end

end

class BinaryTree
  attr_accessor :root
  def initialize(value)
    @root = Element.new(value)
  end

  def insert(root=@root,value)
    if root == nil
      @root = Element.new(value)
    else
    insert(@root.left, value) if root > value
    insert(@root.right, value) if root < value
    end

  end

end

drzewo = BinaryTree.new(6)

drzewo.insert(5)

puts drzewo.root.value