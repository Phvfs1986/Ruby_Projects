# frozen_string_literal: true

module Pieces
  # this class handles all knight operations
  class Knight < Pieces::Base
    include Stepable

    def move
      [[1, 2], [2, 1], [-1, -2], [-2, -1], [-1, 2], [1, -2], [2, -1], [-2, 1]]
    end

    def to_s
      color == :white ? "\u2658" : "\u265E"
    end
  end
end
