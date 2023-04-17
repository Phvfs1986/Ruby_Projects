# frozen_string_literal: true

# this module takes care of all pieces that move more than 1 space at a time
module Slideable
  def possible_moves
    moves = []
    move.each do |x, y|
      current_x, current_y = location
      loop do
        current_x += x
        current_y += y
        current_location = [current_x, current_y]
        break unless board.in_bounds?(current_location)

        moves << current_location if board.empty?(current_location)
        if opponent?(current_location)
          moves << current_location
          break
        end
        break if !board.empty?(current_location) && !opponent?(current_location)
      end
    end
    moves
  end
end
