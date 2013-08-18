=begin
Implementation of a Binary Search Tree in Ruby.

Includes depth-first search and breadth-first search.

=end

class BinarySearchTree
  attr_reader :root

  def initialize(root_node = nil)
    @root = root_node
  end

  def insert(value)
    @root = insert_value(@root, value)
  end

  def insert_value(tnode, value)
    if tnode.nil?
      tnode = Node.new(value)
    elsif value < tnode.value
      tnode.left = insert_value(tnode.left, value)
    elsif value > tnode.value
      tnode.right = insert_value(tnode.right, value)
    elsif value == tnode.value
      tnode.value = value
    end

    tnode
  end

  def delete_node(tnode, node)
    if tnode == node
      tnode = remove(tnode)
    elsif node < tnode
      tnode.left = delete_node(tnode.left, node)
    else
      tnode.right = delete_node(tnode.right, node)
    end
    tnode
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      node = nil
    elsif !node.left.nil? && node.right.nil?
      node = node.left
    elsif node.left.nil? && !node.right.nil?
      node = node.right
    else
      node = replace_parent(node)
    end
    node
  end

  def replace_parent(node)
    node.value = successor_value(node.right)
    node.right = update(node.right)
    node
  end

  def successor_value(node)
    unless node.left.nil?
      successor_value(node.left)
    end
    node.value
  end

  def update(node)
    unless node.left.nil?
      node.left = update(node)
    end
    node.right
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

  def breadth_first_search(target)
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target

      queue << current_node.left if current_node.left
      queue << current_node.right if current_node.right
    end

    nil
  end

end

class Node
  attr_accessor :left, :right, :value

  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def <=>(otherNode)
    @value <=> otherNode.value
  end
end