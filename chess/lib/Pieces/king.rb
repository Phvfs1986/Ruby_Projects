# frozen_string_literal: true

module Pieces
  # this class handles all king operations
  class King < Pieces::Base
    include Stepable

    def move
      [[0, -1], [0, 1], [-1, 0], [1, 0], [-1, -1], [1, 1], [1, -1], [-1, 1]]
    end

    def to_s
      color == :white ? "\u2654" : "\u265A"
    end
  end
end
