# frozen_string_literal: true

# hahaha
class Board
  attr_reader :board, :p_choice
  attr_accessor :last_piece_played, :last_color_played, :player_one, :player_two

  class Player
    attr_reader :name, :symbol, :player_count

    @@player_count = 0

    def initialize
      @@player_count += 1
      puts "Player #{@@player_count} choose your symbol"
      @symbol = gets.chomp
      puts "Player #{@@player_count} choose your name"
      @name = gets.chomp
    end
  end

  def initialize
    @board = Array.new(6) { Array.new(7) { 'O' } }
    @player_one = Player.new
    @player_two = Player.new
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
      player_turn(@player_one)
      display_board
      return if turn_count >= 3 && game_over?

      player_turn(@player_two)
      display_board
      turn_count += 1
      return if turn_count >= 3 && game_over?
    end
  end

  def player_turn(player)
    loop do
      @p_choice = verify_input(player_input(player))
      break if @p_choice

      puts 'Invalid input!'
    end
    update_board(5, @p_choice.to_i, player)
  end

  def verify_input(number)
    return number if number.match?(/^[1-7]$/)
  end

  def player_input(player)
    puts "#{player.name}, please choose a column between 1 and 7"
    gets.chomp
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

  def check_vertical(player)
    flat = @board.flatten
    flat.each_with_index do |v, i|
      if v == player.symbol && flat[i + 7] == player.symbol && flat[i + 14] == player.symbol && flat[i + 21] == player.symbol 
        puts "Winner is #{player.symbol}!"
        return true
      end
    end
    false
  end

  def check_horizontal(player)
    @board.each do |v|
      flat = v.flatten
      flat.each_with_index do |v1, i1|
        if v1 == player.symbol && flat[i1 + 1] == player.symbol && flat[i1 + 2] == player.symbol && flat[i1 + 3] == player.symbol
          puts "Winner is #{player.symbol}!"
          return true
        end
      end
    end
    false
  end

  def check_diagonal(player)
    row = @last_piece_played[0]
    column = @last_piece_played[1]
    if @board[row][column] == player.symbol && @board[row - 1][column + 1] == player.symbol && @board[row - 2][column + 2] == player.symbol && @board[row - 3][column + 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    elsif @board[row][column] == player.symbol && @board[row + 1][column - 1] == player.symbol && @board[row + 2][column - 2] == player.symbol && @board[row + 3][column - 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    elsif @board[row][column] == player.symbol && @board[row + 1][column + 1] == player.symbol && @board[row + 2][column + 2] == player.symbol && @board[row + 3][column + 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    elsif @board[row][column] == player.symbol && @board[row - 1][column - 1] == player.symbol && @board[row - 2][column - 2] == player.symbol && @board[row - 3][column - 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    end
    false
  end

  def game_over?
    check_horizontal(@player_one)
    check_horizontal(@player_two)
    check_diagonal(@player_one)
    check_diagonal(@player_two)
    check_vertical(@player_one)
    check_vertical(@player_two)
  end
end

game = Board.new
game.start_game
