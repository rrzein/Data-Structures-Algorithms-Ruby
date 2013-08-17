=begin
Implementation of a Max Heap in Ruby.

To qualify as a heap, a binary tree must satisfy the following requirements: 
  - For a node B with parent node A, the key of B is smaller than the key of A.
  - For all levels of the tree except the last one, all levels must be fully-filled. If the last level isn't fully filled, it must be filled from left to right.

Heap sort is included.

=end

class Heap
  attr_accessor :heap

  def initialize(arr=[])
    @heap = []

    arr.each { |el| push(el) } unless arr.empty?
  end

  # Add an element to the array.
  # Time complexity: O(log n)

  def push(val)
    @heap << val
    idx = @heap.length - 1
    up_heap(idx)
  end

  # Remove the largest element in the array, the root.
  # Time complexity: O(log n)

  def pop
    removed = @heap.shift
    unless empty?
      last_el = @heap.pop
      @heap.unshift(last_el)
      down_heap(0)
    end

    removed
  end

  # Find the value of the smallest element in the array.
  # Time complexity: O(1)

  def min
    @heap.last
  end

  # Sort the heap.
  # Time complexity: O(n log n)

  def sort
    dup_heap = Heap.new(self.heap)
    sorted_arr = []

    until dup_heap.empty?
      sorted_arr.unshift(dup_heap.pop)
    end

    sorted_arr
  end

  def empty?
    @heap.length == 0
  end

  private

  def up_heap(idx)
    if has_parent?(idx)
      parent_idx = ((idx - 1)/2)

      if @heap[parent_idx] < @heap[idx]
        swap(idx, parent_idx)
        up_heap(parent_idx)
      end
    end
  end

  def down_heap(idx)
    if smaller_than_children?(idx)
      swap_child_idx = greater_child_idx(idx)
      swap(idx, swap_child_idx)
      down_heap(swap_child_idx)
    end
  end

  def swap(idx1, idx2)
    @heap[idx1], @heap[idx2] = @heap[idx2], @heap[idx1]
  end

  def has_parent?(idx)
    idx != 0
  end

  def smaller_than_children?(idx)
    if no_children?(idx)
      return false
    elsif one_child?(idx)
      return @heap[idx] < @heap[2 * idx + 1]
    else
      return @heap[idx] < @heap[2 * idx + 1] || @heap[idx] < @heap[2 * idx + 2]
    end
  end

  def no_children?(idx)
    @heap.length < ((idx * 2) + 2)
  end

  def one_child?(idx)
    @heap.length == ((idx * 2) + 2)
  end

  def greater_child_idx(idx)
    return (2 * idx + 1) if one_child?(idx)

    if @heap[2 * idx + 1] > @heap[2 * idx + 2]
      2 * idx + 1
    else
      2 * idx + 2
    end
  end

end