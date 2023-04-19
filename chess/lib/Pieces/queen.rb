# frozen_string_literal: true

module Pieces
  # this class handles all queen operations
  class Queen < Pieces::Base
    include Slideable

    def move
      [[-1, -1], [-1, 1], [1, -1], [1, 1], [0, 1], [0, -1], [-1, 0], [0, -1]]
    end

    def to_s
      color == :white ? "\u2655" : "\u265B"
    end
  end
end
