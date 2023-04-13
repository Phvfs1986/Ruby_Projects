# frozen_string_literal: true

# this class handles all rook operations
class Rook < Piece
  include Slideable

  def move
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

  def to_s
    color == :white ? "\u2656" : "\u265C"
  end
end
