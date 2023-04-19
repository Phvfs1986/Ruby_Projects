# frozen_string_literal: true

module Pieces
# this class handles all bishop operations
  class Bishop < Pieces::Base
    include Slideable

    def move
      [[-1, -1], [1, -1], [-1, 1], [1, 1]]
    end

    def to_s
      color == :white ? "\u2657" : "\u265D"
    end
  end
end
