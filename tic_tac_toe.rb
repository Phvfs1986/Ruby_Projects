# frozen_string_literal: true

# this is the board
class Board
  def initialize
    @board = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    @turns = 0
  end

  def show_turns
    @turns
  end

  def turns
    @turns += 1
  end

  def check_across
    @board.each do |i|
      if i.all? { |j| j == 'X' }
        puts 'Winner is X!'
        @turns = 10
      elsif i.all? { |j| j == 'O' }
        puts 'Winner is O!'
        @turns = 10
      end
    end
  end

  def check_vertical
    flat = @board.flatten
    flat.each_with_index do |v, i|
      if v == 'X' && flat[i + 3] == 'X' && flat[i + 6] == 'X'
        puts 'Winner is X!'
        @turns = 10
      elsif v == 'O' && flat[i + 3] == 'O' && flat[i + 6] == 'O'
        puts 'Winner is O!'
        @turns = 10
      end
    end
  end

  def check_diagonal
    center = @board[1][1]
    return unless %w[X O].include?(center)
    return unless @board[0][0] && @board[2][2] == center

    puts "Winner is #{center}!"
    @turns = 10
  end

  def show_board
    @board.each_with_index do |element, idx|
      element.each_with_index do |e, idx2|
        print e
        print ' | ' if idx2 != 2
      end
      puts ''
      print '---------' if idx != 2
      puts ''
    end
  end

  def edit_board(player)
    puts player.name
    @board[player.line][player.column] = player.choice
  end

  def check_board(player)
    puts "#{player.name} choose a line and a column (separated by ENTER)."
    player.line = gets.chomp.to_i
    player.column = gets.chomp.to_i
    while @board[player.line][player.column] == 'X' || @board[player.line][player.column] == 'O'
      puts 'Spot already selected. Choose another one.'
      puts "#{player.name} choose a line and a column (separated by ENTER)."
      player.line = gets.chomp.to_i
      player.column = gets.chomp.to_i
    end
  end
end

# this is the player one class
class PlayerOne
  attr_accessor :name, :column, :line, :choice

  def initialize(name)
    @name = name
    @choice = 'X'
  end

  def player_play(column, line)
    @column = column
    @line = line
  end
end

# this is player two class
class PlayerTwo < PlayerOne
  attr_accessor :column, :line, :choice

  def initialize(name)
    super
    @choice = 'O'
  end
end

def play_game(pl1, pl2, board)
  loop do
    board.show_board
    board.check_board(pl1)
    board.edit_board(pl1)
    board.show_board
    board.check_across
    board.check_diagonal
    board.check_vertical
    board.turns
    return if board.show_turns > 9

    board.check_board(pl2)
    board.edit_board(pl2)
    board.show_board
    board.check_across
    board.check_diagonal
    board.check_vertical
    board.turns
    return if board.show_turns > 9
  end
end

board = Board.new
puts board.show_turns
puts "Enter Player 1's name"
p1 = gets.chomp
puts "Enter Player 2's name"
p2 = gets.chomp
player_one = PlayerOne.new(p1)
player_two = PlayerTwo.new(p2)
play_game(player_one, player_two, board)
