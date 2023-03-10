# frozen_string_literal: true

# This class hold all the nodes
class LinkedList
  # this class has all the nodes methods
  class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value, @head)
    else
      current = @head
      current = current.next_node until current.next_node.nil?
      current.next_node = Node.new(value, nil)
      @tail = current.next_node
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def head
    @head.value
  end

  def tail
    @tail.value
  end

  def size
    current = @head
    count = 1
    until current.next_node.nil?
      current = current.next_node
      count += 1
    end
    "There are #{count} elements in the list"
  end

  def at(index)
    current = @head
    count = 0
    until current.nil?
      return "Element: #{current.value}" if count == index

      current = current.next_node
      count += 1
    end
    'Node does not exist'
  end

  def pop
    current = @head
    previous = nil
    until current.next_node.nil?
      previous = current
      current = current.next_node
    end
    previous.next_node = current.next_node
  end

  def contains?(value)
    current = @head
    count = 0
    until current.nil?
      return count if current.value == value

      count += 1
      current = current.next_node
    end
    'Value does not exist in the list'
  end

  def find(value)
    current = @head
    count = 0
    until current.nil?
      return "Found #{value} at index: #{count}" if current.value == value

      current = current.next_node
      count += 1
    end
  end

  def insert_at(value, index)
    current = @head
    previous = nil
    count = 0
    until current.next_node.nil?
      previous.next_node = Node.new(value, current) if count == index
      count += 1
      previous = current
      current = current.next_node
    end
  end

  def remove_at(index)
    current = @head
    previous = nil
    count = 0
    return @head = @head.next_node if index.zero?

    until current.next_node.nil?
      previous.next_node = current.next_node if index == count
      count += 1
      previous = current
      current = current.next_node
    end
  end

  def to_s
    current = @head
    until current.nil?
      print "(#{current.value}) -> "
      current = current.next_node
    end
    'nil'
  end
end
