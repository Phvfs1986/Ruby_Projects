# frozen_string_literal: true

# this class handles players variables
class Player
  attr_accessor :name, :symbol

  @players = 0

  class << self
    attr_accessor :players
  end

  def initialize
    self.class.players += 1
    puts "Player #{Player.players} choose your symbol"
    @symbol = gets.chomp
    puts "Player #{Player.players} choose your name"
    @name = gets.chomp
  end
end
