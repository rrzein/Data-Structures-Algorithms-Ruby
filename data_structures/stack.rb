# Implementation of a stack in Ruby.

Node = Struct.new(:back, :front, :value)

class Stack
  def initialize
    @pointer = nil
    @size = 0
  end

  def push(value)
    prior_node = ((@pointer) ? @pointer : nil)
    node = Node.new(prior_node, value)
    prior_node.front = node if prior_node
    @size += 1
    @pointer = node
    @pointer.value
  end 

  def pop
    prior_node = @pointer.back
    prior_node.front = nil if prior_node
    @size -= 1
    @pointer = prior_node
    @pointer.value
  end

  def top
    @pointer.value
  end

  def size
    @size
  end 

  def empty?
    true if @size == 0
  end

  def each(&blk)

  end

end