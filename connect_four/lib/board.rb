# frozen_string_literal: true

require_relative 'player'
require_relative 'game'

# board class handles all board display
class Board
  attr_reader :board, :p_choice, :game
  attr_accessor :payer_one, :player_two, :symbol_array

  def initialize
    @board = Array.new(6) { Array.new(7) { '.' } }
    @player_one = Player.new
    @player_two = Player.new
    @symbol_array = [@player_one.symbol, @player_two.symbol]
    @game = Game.new
  end

  def display_board
    row_number = 1
    @board.each do |row|
      print row.join(' ')
      print " #{row_number}"
      puts ''
      row_number += 1
    end
    puts (1..7).to_a.join(' ')
  end

  def start_game
    game.turn_count = 0
    loop do
      player = turn_order
      verified_input = game.player_turn(player)
      update_board(5, verified_input, player)
      display_board
      return game.game_result(board, player) if game.game_over?(@board)

      game.turn_count += 1
    end
  end

  def turn_order
    game.turn_count.even? ? @player_one : @player_two
  end

  def update_board(row, verified_input, player)
    unless row >= 0
      puts 'Column full!'
      return
    end

    if @symbol_array.include?(@board[row][verified_input - 1])
      update_board(row - 1, verified_input, player)
    else
      @board[row][verified_input - 1] = player.symbol
      @last_piece_played = [row, verified_input - 1]
    end
  end
end
