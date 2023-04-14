# frozen_string_literal: true

class Game
  attr_reader :player_one, :player_two, :board
  attr_accessor :turn_count

  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
  end

  def start_game
    @turn_count = 0
    puts "#{@player_one.name} color is White"
    @player_one.color = 'white'
    puts "#{@player_two.name} color is Black"
    @player_two.color = 'Black'
    loop do
      board.display_board
      player = turn_order
      make_your_move(player)
      @turn_count += 1
    end
  end

  def turn_order
    @turn_count.even? ? @player_one : @player_two
  end

  def make_your_move(player)
    start_pos = select_piece(player)
    end_pos = select_destination(player)
    move_piece(start_pos, end_pos)
  end

  def select_piece(player)
    loop do
      puts "#{player.name} Select a piece:"
      row, column = row_and_column

      return [row, column] if valid_piece?(row, column, player.color)

      puts 'You must select a piece of your color'
    end
  end

  # TO EDIT
  def select_destination(player)
    puts "#{player.name} Select a destiny location:"
    row_and_column
  end

  def row_and_column
    print 'Row: '
    row = gets.chomp.to_i
    print 'Column: '
    column = gets.chomp.to_i
    [row, column]
  end

  def valid_piece?(row, column, player_color)
    piece = board.piece_at([row, column])
    return false if piece == '.'

    piece.color.to_s == player_color
  end

  def move_piece(start_loc, end_loc)
    piece = board.piece_at(start_loc)

    unless piece.possible_moves.include?(end_loc)
      puts 'Move is not legal'
      return
    end

    piece.location = end_loc
    board.put_piece(end_loc, piece)
    board.put_piece(start_loc, '.')
  end
end
