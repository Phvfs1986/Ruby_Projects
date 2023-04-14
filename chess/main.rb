# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/player'
require_relative './lib/game'
require_relative './lib/pieces'

board = Board.set_board

game = Game.new(board, Player.new(:white), Player.new(:black))

game.start_game
