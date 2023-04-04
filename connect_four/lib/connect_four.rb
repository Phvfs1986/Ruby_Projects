# frozen_string_literal: true

# hahaha
class Board
  attr_reader :board, :p_choice
  attr_accessor :last_piece_played, :last_color_played

  def initialize
    @board = Array.new(6) { Array.new(7) { 'O' } }
    @player1 = 'X'
    @player2 = 'O'
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

  def player_turn
    loop do
      @p_choice = verify_input(player_input)
      break if @p_choice

      puts 'Invalid input!'
    end
    update_board(@p_choice.to_i)
  end

  def verify_input(number)
    return number if number.match?(/^[1-7]$/)
  end

  def player_input
    puts 'Player, please choose a column between 1 and 7'
    gets.chomp
  end

  def update_board(row = 5, valid_input = 1, token = 'X')
    unless row >= 0
      puts 'Column full!'
      return
    end

    if @board[row][valid_input - 1] == token
      row -= 1
      update_board(row, valid_input)
    else
      @board[row][valid_input - 1] = token
      @last_piece_played = [row, valid_input - 1]
    end
  end

  def check_vertical
    flat = @board.flatten
    flat.each_with_index do |v, i|
      puts 'Winner is X!' if v == 'X' && flat[i + 7] == 'X' && flat[i + 14] == 'X' && flat[i + 21] == 'X'
    end
  end

  def check_horizontal
    @board.each do |v|
      flat = v.flatten
      flat.each_with_index do |v1, i1|
        puts 'Winner is X!' if v1 == 'X' && flat[i1 + 1] == 'X' && flat[i1 + 2] == 'X' && flat[i1 + 3] == 'X'
      end
    end
  end

  def check_diagonal
    row = @last_piece_played[0]
    column = @last_piece_played[1]
    if @board[row][column] == 'X' && @board[row - 1][column + 1] == 'X' && @board[row - 2][column + 2] == 'X' && @board[row - 3][column + 3] == 'X'
      puts 'Winner is X!'
    elsif @board[row][column] == 'X' && @board[row + 1][column - 1] == 'X' && @board[row + 2][column - 2] == 'X' && @board[row + 3][column - 3] == 'X'
      puts 'Winner is X!'
    elsif @board[row][column] == 'X' && @board[row + 1][column + 1] == 'X' && @board[row + 2][column + 2] == 'X' && @board[row + 3][column + 3] == 'X'
      puts 'Winner is X!'
    elsif @board[row][column] == 'X' && @board[row - 1][column - 1] == 'X' && @board[row - 2][column - 2] == 'X' && @board[row - 3][column - 3] == 'X'
      puts 'Winner is X!'
    end
  end

  def game_over?; end
end
