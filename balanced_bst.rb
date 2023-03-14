# frozen_string_literal: true

# placeholder comment
class Tree
  attr_accessor :root

  def initialize(array)
    @array = array.sort!.uniq!
    @root = build_tree(array)
  end

  # placeholder comment
  class Node
    attr_accessor :data, :left_node, :right_node

    def initialize(data = nil, left_node = nil, right_node = nil)
      @data = data
      @left_node = left_node
      @right_node = right_node
    end
  end

  def build_tree(array, start = 0, ending = (array.length - 1))
    return nil if start > ending

    middle = (start + ending) / 2
    root_node = Node.new(array[middle])

    root_node.left_node = build_tree(array, start, middle - 1)
    root_node.right_node = build_tree(array, middle + 1, ending)

    root_node
  end

  def insert(value, node = root)
    return nil if value == node.data

    if value < node.data
      if node.left_node.nil?
        node.left_node = Node.new(value)
      else
        insert(value, node.left_node)
      end
    elsif value > node.data
      if node.right_node.nil?
        node.right_node = Node.new(value)
      else
        insert(value, node.right_node)
      end
    end
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left_node = delete(value, node.left_node)
    elsif value > node.data
      node.right_node = delete(value, node.right_node)
    else
      return node.right_node if node.left_node.nil?
      return node.left_node if node.right_node.nil?

      node.data = left_smallest(node.right_node)
      node.right_node = delete(node.data, node.right_node)
    end
    node
  end

  def left_smallest(node)
    until node.left_node.nil?
      smallest = node.left_node.data
      node = node.left_node
    end
    smallest
  end

  def find(value, node = root)
    return "#{value} is NOT in the tree." if node.nil?
    return node if value == node.data

    if value < node.data
      find(value, node.left_node)
    elsif value > node.data
      find(value, node.right_node)
    end
  end

  def level_order(&block)
    return if root.nil?

    queue = []
    queue << root
    until queue.empty?
      current = queue[0]
      if block_given?
        block.call(current.data)
      else
        print "#{current.data}  "
      end
      queue << current.left_node unless current.left_node.nil?
      queue << current.right_node unless current.right_node.nil?
      queue.shift
    end
  end

  def inorder(node = root, &block)
    return if node.nil?

    inorder(node.left_node, &block)
    if block_given?
      block.call(node.data)
    else
      print "#{node.data}  "
    end
    inorder(node.right_node, &block)
  end

  def preorder(node = root, &block)
    return if node.nil?

    if block_given?
      block.call(node.data)
    else
      print "#{node.data}  "
    end
    preorder(node.left_node, &block)
    preorder(node.right_node, &block)
  end

  def postorder(node = root, &block)
    return if node.nil?

    postorder(node.left_node, &block)
    postorder(node.right_node, &block)
    if block_given?
      block.call(node.data)
    else
      print "#{node.data}  "
    end
  end

  def height(value)
    return -1 if root.nil?

    lcount = 0
    rcount = 0
    root = find(value)
    left_node = root
    right_node = root

    until left_node.left_node.nil?
      lcount += 1
      left_node = left_node.left_node
    end
    until right_node.right_node.nil?
      rcount += 1
      right_node = right_node.right_node
    end
    lcount > rcount ? lcount + 1 : rcount + 1
  end

  def depth(value, node = root)
    return -1 if node.nil?

    count = 0
    if node.data == value || (count = depth(value, node.left_node)) >= 0 || (count = depth(value, node.right_node)) >= 0
      return count + 1

    end

    count
  end

  def balanced?(node = root)
    return - 1 if node.nil?

    return left_count += 1 if (left_count = height(node.left_node.data)) <= 1

    return right_count += 1 if (right_count = height(node.right_node.data)) <= 1

    if right_count > left_count
      tmp = right_count
      right_count = left_count
      left_count = tmp
    end
    left_count - right_count <= 1 ? 'Tree is BALANCED' : 'Tree is UNBALANCED'
  end

  def rebalance
    puts 'Rebalancing tree...'
    array = []
    level_order do |value|
      array << value
    end
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print

puts tree.balanced?

puts 'Level-Order:'
puts tree.level_order
puts 'Inorder:'
puts tree.inorder
puts 'Preorder:'
puts tree.preorder
puts 'Postorder'
puts tree.postorder

tree.insert(100)
tree.insert(110)
tree.insert(120)
tree.insert(130)
tree.insert(140)
tree.insert(150)

puts tree.balanced?

tree.rebalance

puts tree.balanced?

puts 'Level-Order:'
puts tree.level_order
puts 'Inorder:'
puts tree.inorder
puts 'Preorder:'
puts tree.preorder
puts 'Postorder'
puts tree.postorder

tree.pretty_print
