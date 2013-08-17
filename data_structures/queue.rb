=begin
Implementation of a queue in Ruby, 
which contains elements in a first-in, first-out order.

Uses:
  - Maintaining a queue of processes that are ready to execute or waiting for
a particular event to occur.
  - Buffers.

=end

class Queue
  attr_accessor :head, :tail, :size

  Node = Struct.new(:from, :to, :obj)

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

# Adds an item to the back of the container.
# Time complexity: O(1)

  def push(obj)
    node = Node.new(nil, nil, obj)
    if @tail
      @tail.to = node
      node.from = @tail
      @tail = node
    else
      @head = @tail = node
    end
    @size += 1
    node.obj
  end

# Remove an item from the beginning of the container
# Time complexity: O(1)

  def pop
    return unless @head
    popped = @head
    
    if @head.to
      new_head = @head.to
      new_head.from = nil
      @head = new_head
      size += 1
    else
      empty!
    end

    popped.obj
  end

# Clears the contents of the container.

  def empty!
    @head = @tail = nil
    @size = 0
  end

# Checks if the container is empty.

  def empty?
    @size == 0
  end

end