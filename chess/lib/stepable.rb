# frozen_string_literal: true

# this module takes care of all pieces that move 1 space at a time
module Stepable
  def possible_moves
    moves = []
    move.each do |x, y|
      current_x, current_y = location
      current_x += x
      current_y += y
      current_location = [current_x, current_y]
      next unless board.in_bounds?(current_location)

      moves << current_location if board.empty?(current_location) || opponent?(current_location)
    end
    moves.select { |move| board.in_bounds?(move) }
  end
end
