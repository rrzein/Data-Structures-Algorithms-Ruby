# Implementation of a singly linked list in Ruby

class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end

end

class SinglyLinkedList
  attr_accessor :head, :next

  def initialize(head)
    @head = head
    @next = nil # if the list itself is nested
  end

  def insert(value, after_value)
    insert_node = Node.new(value)

    current_node = @head
    until current_node.value == after_value
      current_node = current_node.next
    end

    after_node = current_node.next
    current_node.next = insert_node
    insert_node.next = after_node
    insert_node
  end

  def delete(delete_value)
    current_node = @head

    if @head.value == delete_value
      @head = current_node.next
      current_node = nil
      return
    end

    until current_node.next.value == delete_value
      current_node = current_node.next
    end

    delete_node = current_node.next
    current_node.next = delete_node.next
    delete_node
  end

  def push(push_value)
    push_node = Node.new(push_value)

    current_node = @head
    while current_node.next
      current_node = current_node.next
    end

    current_node.next = push_node
  end

  def pop
    current_node = @head
    while current_node.next.next
      current_node = current_node.next
      pop_node = current_node.next
    end

    current_node.next = nil
    pop_node
  end

  def reverse
    head_copy = @head.dup
    head_copy.next = nil

    current_node = @head
    current_copy = head_copy

    while current_node.next
      current_node = current_node.next
      new_copy = current_node.dup
      new_copy.next = current_copy
      current_copy = new_copy
      @head = current_copy
    end

  end

  def each(&prc)
    current_node = @head

    while current_node.next
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  def index(value)
    current_index = 0

    current_node = @head
    until current_node.value == value
      current_node = current_node.next
      current_index += 1
    end

    current_index
  end

  def to_array
    arr = []
    current_node = @head

    until current_node.next == nil
      arr << current_node.value
      current_node = current_node.next
    end

    arr
  end

  def flatten
    if flat?
      return self
    else
      current_node = @head
      until current_node.next == nil
        if current_node.next.is_a?(SinglyLinkedList)
          list = flatten(current_node.next)
          list_node = list.head
          until list_node.next == nil
            list_node = list_node.next
          end
          list_node.next = list.next
          current_node = list_node
        end
        current_node = current_node.next
      end
    end
  end

  def flat?
    current_node = @head
    until current_node.next == nil
      return false if current_node.next.is_a?(SinglyLinkedList)
      current_node = current_node.next
    end

    true
  end

  def linear?
    traversed = []
    current_node = @head
    until current_node.next == nil
      traversed << current_node
      return false if traversed.includes?(current_node.next)
      current_node = current_node.next
    end

    true
  end

end