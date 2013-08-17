require '../data_structures/binary_search_tree.rb'

=begin
Implementations of various searching algorithms in Ruby.

=end


def binary_search(array, target)
  return nil if array.count == 0

  median = array.length / 2
  left = array[0...median]
  right = array[median + 1..-1]

  return median if array[median] == target
  if target < array[median]
    return binary_search(left, target)
  else
    sub_answer = binary_search(right, target)
    (sub_answer.nil?) ? nil : (sub_anser + median + 1)
  end

end

def depth_first_search(node, target)
  return node if node.value == target

  children = [node.left, node.right]

  children.each do |child|
    next if child.nil?

    result = depth_first_search(child, target)
    return result unless result.nil?
  end

  nil
end

def breadth_first_search(node, target)
  queue = [node]
  until queue.empty?
    current_node = queue.shift
    return current_node if current_node.value == target

    queue << current_node.left if current_node.left
    queue << current_node.right if current_node.right
  end

  nil
end