#Implementation of a doubly linked list in Ruby

class Deque
  attr_accessor :head, :tail

  Node = Struct.new(:from, :to, :obj)

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

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

  def empty!
    @head = @tail = nil
    @size = 0
  end

  def empty?
    @size == 0
  end

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

  def each(&blk)
    return unless @head
    current_node = @head
    while current_node
      blk.call(current_node.obj)
      current_node = current_node.to
    end
  end

  def each_reverse(&blk)
    return unless @tail
    current_node = @tail
    while current_node
      blk.call(current_node.obj)
      current_node = current_node.from
    end
  end

  def reverse
    current_node = @head
    while current_node
      current_node.from, current_node.to = current_node.to, current_node.from
    end

    @head, @tail = @tail, @head
  end

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

  def to_a
    array = []
    current_node = @head
    while current_node
      array << current_node.obj
      curent_node = current_node.to
    end

    array
  end

  def size
    @size
  end

end