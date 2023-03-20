# frozen_string_literal: true

# Best i could do
class Board
  attr_reader :current, :previous

  POSSIBLE_MOVES = [[1, 2], [2, 1], [-1, -2], [-2, -1], [-1, 2], [1, -2], [2, -1], [-2, 1]].freeze

  def initialize(current, previous)
    @current = current
    @previous = previous
  end

  def make_path
    POSSIBLE_MOVES.map { |m| [@current[0] + m[0], @current[1] + m[1]] }.map do |n|
      Board.new(n, self) if current[0].between?(0, 7) && current[1].between?(0, 7)
    end
  end
end

def display(position)
  display(position.previous) unless position.previous.nil?
  print "#{position.current} "
end

def knight_move(start, ending)
  queue = []
  position = Board.new(start, nil)
  until position.current == ending
    position.make_path.each { |node| queue << node }
    position = queue.shift
  end
  puts "Here's your path:"
  display(position)
  puts ''
end

knight_move([0, 0], [1, 2])
