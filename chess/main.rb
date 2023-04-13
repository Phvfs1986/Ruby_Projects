# frozen_string_literal: true

require_relative './lib/piece'
require_relative './lib/board'
require_relative './lib/pawn'
require_relative './lib/rook'
require_relative './lib/knight'
require_relative './lib/bishop'
require_relative './lib/queen'
require_relative './lib/king'

board = Board.set_board

board.display_board

board.make_your_move

board.display_board
