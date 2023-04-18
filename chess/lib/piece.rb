# frozen_string_literal: true

require_relative 'slideable'
require_relative 'stepable'

# parent class of all pieces
class Piece
  attr_reader :color, :board, :starting_location
  attr_accessor :location

  def initialize(color, location, board)
    @color = color
    @location = location
    @board = board
    @starting_location = location
  end

  def opponent?(location)
    board.piece_at(location) != '.' && !board.piece_at(location).nil? && board.piece_at(location).color != color
  end
end
