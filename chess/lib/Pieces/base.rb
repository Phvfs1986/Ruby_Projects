# frozen_string_literal: true

# parent class of all pieces
module Pieces
  class Base
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
end
