=begin
Implementation of a deque in Ruby.

Uses:
  -Undo-redo operations in software applications.
  -Checking to see if a string is a palindrome.

=end

class Deque
  attr_accessor :head, :tail

  Node = Struct.new(:from, :to, :obj)

  # Initialize the empty deque.

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  # Add an object to the end of the deque.
  # Time complexity: O(1)

  def push(obj)
    node = Node.new(nil, nil, obj)
    if @tail
      node.from = @tail
      @tail.to = node
      @tail = node
    else
      @head = @tail = node
    end

    @size += 1
    obj
  end

  # Remove an object from the end of the deque.
  # Time complexity: O(1)

  def pop
    popped = @tail

    if @size == 1
      empty!
    else
      @tail = @tail.from
      @tail.to = nil
      @size -= 1
    end

    popped.obj
  end

  # Remove an object from the front of the deque.
  # Time complexity: O(1)

  def shift
    shifted = @head

    if @size == 1
      empty!
    else
      @head = @head.to
      @head.from = nil
      @size -= 1
    end

    shifted.obj
  end

  # Add an object to the front of the deque.
  # Time complexity: O(1)

  def unshift(obj)
    node = Node.new(nil, nil, obj)
    if @head
      @head = @tail = node
    else
      node.to = @head
      @head.from = node
      @head = node
    end
    @size += 1

    node.obj
  end

  # Remove all elements from the deque.
  # Time complexity: O(1)

  def empty!
    @head = @tail = nil
    @size = 0
  end

  def empty?
    @size == 0
  end

  # Remove an object from the middle of the deque, starting from the beginning.
  # Time complexity: O(n)

  def remove(obj)
    current_node = @head
    until current_node.obj == obj
      current_node = current_node.next
      return "Object not found" unless current_node
    end
    from_node = current_node.from
    to_node = current_node.to

    from_node.to = to_node
    to_node.from = from_node

    obj
  end

  # Remove an object from the end of the deque, starting from the end.
  # Time complexity: O(n)

  def remove_reverse(obj)
    current_node = @tail
    until current_node.obj == obj
      current_node = current_node.from
      return "Object not found" unless current_node
    end
    from_node = current_node.from
    to_node = current_node.to

    from_node.to = to_node
    to_node.from = from_node

    obj
  end

  # Iterate over the deque from beginning to end and call a block on each object.
  # Time complexity: O(n) irrespective of block.

  def each(&blk)
    return unless @head
    current_node = @head
    while current_node
      blk.call(current_node.obj)
      current_node = current_node.to
    end
  end

  # Iterate over the deque from end to beginning and call a block on each object.
  # Time complexity: O(n) irrespective of block.

  def each_reverse(&blk)
    return unless @tail
    current_node = @tail
    while current_node
      blk.call(current_node.obj)
      current_node = current_node.from
    end
  end

  # Reverse the order of the deque.
  # Time complexity: O(n)

  def reverse!
    current_node = @head
    while current_node
      current_node.from, current_node.to = current_node.to, current_node.from
    end

    @head, @tail = @tail, @head
  end

  # Find the index of an object in the deque.
  # Time complexity: O(n)

  def index_of(obj)
    current_node = @head
    index = 0
    while current_node
      return index if current_node.obj == obj
      current_node = current_node.to
      index += 1
    end

    "Object not found."
  end

  # Return an array representation of the deque.
  # Time complexity: O(n)

  def to_a
    array = []
    current_node = @head
    while current_node
      array << current_node.obj
      curent_node = current_node.to
    end

    array
  end

  # Return the size of the deque.
  # Time complexity: O(1)

  def size
    @size
  end

end