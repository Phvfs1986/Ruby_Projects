# frozen_string_literal: true

# hahaha
require './player'
require './game'

class Board
  attr_reader :board, :p_choice, :game
  attr_accessor :last_piece_played, :last_color_played, :player_one, :player_two

  def initialize
    @board = Array.new(6) { Array.new(7) { 'O' } }
    @player_one = Player.new
    @player_two = Player.new
    @game = Game.new
    puts "Player 1 choose your symbol"
    @player_one.symbol = gets.chomp
    puts "Player 1 choose your name"
    @player_one.name = gets.chomp
    puts "Player 2 choose your symbol"
    @player_two.symbol = gets.chomp
    puts "Player 2 choose your name"
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
      display_board
      p_choice = game.player_turn(@player_one)
      update_board(5, p_choice, @player_one)
      display_board
      return if turn_count >= 3 && game.game_over?(@player_one, @board, @last_piece_played)

      p_choice = game.player_turn(@player_two)
      update_board(5, p_choice, @player_two)
      display_board
      turn_count += 1
      return if turn_count >= 3 && game.game_over?(@player_two, @board, @last_piece_played)
    end
  end

  def update_board(row, valid_input = 1, player)
    unless row >= 0
      puts 'Column full!'
      return
    end

    if @board[row][valid_input - 1] == player.symbol
      row -= 1
      update_board(row, valid_input, player)
    else
      @board[row][valid_input - 1] = player.symbol
      @last_piece_played = [row, valid_input - 1]
    end
  end
end

board = Board.new
board.start_game
