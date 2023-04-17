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
    puts "#{@player_two.name} color is Black"
    loop do
      system 'clear'
      board.display_board
      player = turn_order
      make_your_move(player)
      board.check?(player)
      return if board.check_mate?(player)

      @turn_count += 1
    end
  end

  def turn_order
    @turn_count.even? ? @player_one : @player_two
  end

  def make_your_move(player)
    start_pos = select_piece(player)
    piece = board.piece_at(start_pos)
    end_pos = select_destination(player, piece)
    move_piece(start_pos, end_pos, piece)
  end

  def select_piece(player)
    loop do
      puts "#{player.name} Select a piece:"
      row, column = row_and_column

      return [row, column] if valid_piece?(row, column, player.color)

      puts 'You must select a piece of your color'
    end
  end

  def select_destination(player, piece)
    loop do
      puts "#{player.name} Select a destiny location:"
      row, column = row_and_column

      if piece.possible_moves.include?([row, column]) && (board.empty?([row, column]) || piece.opponent?([row, column]))
        return [row, column]
      end

      puts 'You must select a valid location'
    end
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

    piece.color.to_s == player_color.to_s
  end

  def move_piece(start_loc, end_loc, piece)
    piece.location = end_loc
    board.put_piece(end_loc, piece)
    board.put_piece(start_loc, '.')
  end
end
