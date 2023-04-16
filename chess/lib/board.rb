# frozen_string_literal: true

# this class handles all board operations
class Board
  attr_reader :grid, :game

  def initialize
    @grid = Array.new(8) { Array.new(8) { '.' } }
  end

  def piece_at(location)
    row = location[0]
    column = location[1]
    grid[row][column]
  end

  def put_piece(location, piece)
    row = location[0]
    column = location[1]
    grid[row][column] = piece
  end

  def self.set_board
    board = new
    board.put_pawns(board)
    board.put_rooks(board)
    board.put_knights(board)
    board.put_bishops(board)
    board.put_queens(board)
    board.put_kings(board)
    board
  end

  def put_pawns(board)
    8.times do |number|
      board.put_piece([1, number], Pawn.new(:black, [1, number], board))
      board.put_piece([6, number], Pawn.new(:white, [6, number], board))
    end
  end

  def put_rooks(board)
    board.put_piece([0, 0], Rook.new(:black, [0, 0], board))
    board.put_piece([0, 7], Rook.new(:black, [0, 7], board))
    board.put_piece([7, 0], Rook.new(:white, [7, 0], board))
    board.put_piece([7, 7], Rook.new(:white, [7, 7], board))
  end

  def put_knights(board)
    board.put_piece([0, 1], Knight.new(:black, [0, 1], board))
    board.put_piece([0, 6], Knight.new(:black, [0, 6], board))
    board.put_piece([7, 1], Knight.new(:white, [7, 1], board))
    board.put_piece([7, 6], Knight.new(:white, [7, 6], board))
  end

  def put_bishops(board)
    board.put_piece([0, 2], Bishop.new(:black, [0, 2], board))
    board.put_piece([0, 5], Bishop.new(:black, [0, 5], board))
    board.put_piece([7, 2], Bishop.new(:white, [7, 2], board))
    board.put_piece([7, 5], Bishop.new(:white, [7, 5], board))
  end

  def put_queens(board)
    board.put_piece([0, 3], Queen.new(:black, [0, 3], board))
    board.put_piece([7, 3], Queen.new(:white, [7, 3], board))
  end

  def put_kings(board)
    board.put_piece([0, 4], King.new(:black, [0, 4], board))
    board.put_piece([7, 4], King.new(:white, [7, 4], board))
  end

  def display_board
    row_number = 0
    grid.each do |row|
      print row.join(' ')
      print " #{row_number}"
      puts ''
      row_number += 1
    end
    puts (0..7).to_a.join(' ')
  end

  def in_bounds?(location)
    row = location[0]
    column = location[1]

    row < grid.length && column < grid[0].length && row >= 0 && column >= 0
  end

  def empty?(location)
    row = location[0]
    column = location[1]
    grid[row][column] == '.'
  end

  def check?

  end
end
