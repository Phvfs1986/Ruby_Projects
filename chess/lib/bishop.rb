# frozen_string_literal: true

# this class handles all bishop operations
class Bishop < Piece
  include Slideable

  def move
    [[-1, -1], [1, -1], [-1, 1], [1, 1]]
  end

  def to_s
    color == :white ? "\u2657" : "\u265D"
  end
end
