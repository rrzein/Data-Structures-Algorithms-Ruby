=begin
Implementation of a stack in Ruby.

Uses:
  -Expression evaluation via conversion to Reverse Polish Notation.
  -Storing return addresses for subroutines in recurrence operations.

=end

Node = Struct.new(:from, :to, :obj)

class Stack
  def initialize
    @pointer = nil
    @size = 0
  end

  # Add an object to the top of the stack.
  # Time complexity: O(1)

  def push(obj)
    prior_node = ((@pointer) ? @pointer : nil)
    node = Node.new(prior_node, value)
    prior_node.to = node if prior_node
    @size += 1
    @pointer = node
    @pointer.obj
  end 

  # Remove an object from the top of the stack.
  # Time complexity: O(1)

  def pop
    prior_node = @pointer.from
    prior_node.to = nil if prior_node
    @size -= 1
    @pointer = prior_node
    @pointer.obj
  end

  # Return the object at the top of the stack.

  def top
    @pointer.obj
  end

  # Return the size of the stack.

  def size
    @size
  end 

  # Check to see if the stack is empty.

  def empty?
    true if @size == 0
  end

  # Iterate over the stack in LIFO order.
  # Time complexity: O(n)

  def each(&blk)
    current_node = @pointer
    while current_node
      blk.call(current_node.obj)
      current_node = current_node.from
    end
  end

end