# frozen_string_literal: true

# this class handles all pawn operations
class Pawn < Piece
  def forward_move
    color == :white ? -1 : 1
  end

  def possible_moves
    moves = []
    current_x, current_y = location

    one_step = [current_x + forward_move, current_y]
    return moves unless board.empty?(one_step)

    moves << one_step

    if location == starting_location
      two_step = [current_x + (forward_move * 2), current_y]
      moves << two_step if board.empty?(two_step) && board.empty?(one_step)
    end

    diagonal_left = [current_x + forward_move, current_y + 1]
    diagonal_right = [current_x + forward_move, current_y - 1]

    moves << diagonal_left if opponent?(diagonal_left)
    moves << diagonal_right if opponent?(diagonal_right)

    moves.select { |move| board.in_bounds?(move) }
  end

  def to_s
    color == :white ? "\u2659" : "\u265F"
  end
end
