# frozen_string_literal: true

# hahaha
require './lib/player'
require './lib/game'

# board class handles all board display
class Board
  attr_reader :board, :p_choice, :game
  attr_accessor :payer_one, :player_two, :symbol_array

  def initialize
    @board = Array.new(6) { Array.new(7) { '.' } }
    @symbol_array = []
    @player_one = Player.new
    @player_two = Player.new
    @game = Game.new
    puts 'Player 1 choose your symbol'
    @player_one.symbol = gets.chomp
    @symbol_array << @player_one.symbol
    puts 'Player 1 choose your name'
    @player_one.name = gets.chomp
    puts 'Player 2 choose your symbol'
    @player_two.symbol = gets.chomp
    @symbol_array << @player_two.symbol
    puts 'Player 2 choose your name'
    @player_two.name = gets.chomp
  end

  def introduction
    puts <<~HEREDOC
      Welcome to the Connect Four game of the century!
      Two players may enter the arena, but only one will be victorious!
    HEREDOC
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
    turn_count = 0
    loop do
      player = @player_one if turn_count.even?
      player = @player_two if turn_count.odd?
      verified_input = game.player_turn(player)
      update_board(5, verified_input, player)
      display_board
      return player.name if game.game_over?(@board)

      turn_count += 1
    end
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

board = Board.new
player = board.start_game
puts "winner is #{player}"
