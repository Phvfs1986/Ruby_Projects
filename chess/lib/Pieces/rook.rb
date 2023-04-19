# frozen_string_literal: true

module Pieces
  # this class handles all rook operations
  class Rook < Pieces::Base
    include Slideable

    def move
      [[0, 1], [0, -1], [1, 0], [-1, 0]]
    end

    def to_s
      color == :white ? "\u2656" : "\u265C"
    end
  end
end
