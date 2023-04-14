# frozen_string_literal: true

class Player
  attr_accessor :name, :color

  @players = 0

  class << self
    attr_accessor :players
  end

  def initialize(color)
    self.class.players += 1
    puts "Player #{Player.players} choose your name"
    @name = gets.chomp
    @color = color
  end
end
