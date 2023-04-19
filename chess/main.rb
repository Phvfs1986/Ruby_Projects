# frozen_string_literal: true

require 'byebug'

require_relative './lib/Pieces/base'

Dir['./lib/*.rb'].uniq.each { |file| require_relative file }
Dir['./lib/Pieces/*.rb'].uniq.each { |file| require_relative file }


board = Board.set_board

game = Game.new(board, Player.new(:white), Player.new(:black))

game.start_game
