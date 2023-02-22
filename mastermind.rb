# frozen_string_literal: true

# defining which colors are avaible for play
module Colors
  attr_reader :colors

  def select_color
    @colors = %w[green red yellow blue black white purple]
  end
end

# this class determines what the computer player can do
class ComputerPlayer
  include Colors
  attr_accessor :code, :cpu_guess_array

  def initialize
    @name = 'Computer'
    @code = select_color.sample(4)
    @cpu_guess_array = []
  end

  def shuffle_code
    @code = select_color.sample(4)
  end

  def to_s
    "#{@name} colors are #{@code}"
  end
end

# this class determines what the human player can do
class HumanPlayer
  include Colors
  attr_accessor :name, :guess_array

  def initialize(name)
    @name = name
    @guess_array = []
  end

  def colors_guess(guess)
    @guess_array.push(guess)
  end

  def clear_guesses
    @guess_array = []
  end

  def to_s
    "#{@name}'s guesses so far: #{@guess_array}"
  end
end

# this class determines all game functions
class Game
  attr_accessor :turns, :winner

  def initialize
    @turns = 0
    @winner = ''
  end

  def win_con(cpu, human)
    if cpu.code == human.guess_array
      puts "#{human.name} is the winner!"
      @winner = human.name
      @turns = 12
    else
      cpu.code.select.each_with_index do |ccolor, cidx|
        if human.guess_array[cidx] == ccolor
          puts "#{cidx + 1}: match #{ccolor}"
        elsif human.guess_array.include?(ccolor)
          puts "#{ccolor} is part of the code. But in the wrong position."
        end
      end
      not_in_code = human.guess_array - cpu.code
      unless not_in_code.empty?
        if not_in_code.length > 1
          puts "#{not_in_code.join(', ')} are not in the code."
        else
          puts "#{not_in_code} is not in the code."
        end
      end
    end
  end

  def play_game(cpu, human)
    puts "\nThe colors avaible are: #{cpu.colors.join(', ')}"
    puts "You have to guess in what order the colors are in the code.\nThe code consists of 4 colors. Good luck!\n"
    choice = 'y'
    while choice.include?('y')
      turns_count(cpu, human)
      puts "\nPlay again? (Y/N)"
      choice = gets.chomp.downcase
    end
  end

  def turns_count(cpu, human)
    cpu.shuffle_code
    @turns = 0
    while @turns < 12
      round(cpu, human)
      @turns += 1
    end
    puts winner_message(human)
  end

  def round(cpu, human)
    human.clear_guesses
    guesses = 0
    puts "\nGuess the 4 colors"
    while guesses < 4
      print "#{guesses + 1}: "
      human.colors_guess(gets.chomp.downcase)
      guesses += 1
    end
    puts ''
    win_con(cpu, human)
  end

  def winner_message(human)
    human_message = "It's a happy day! Humanity triumphs once again!\n"
    cpu_message = "It's a sad day for humanity. The computers took over the world and enslaved the human race.\n"

    @winner == human.name ? human_message : cpu_message
  end
end

puts "\nWelcome to the 'Mastermind' game of the century! Who will triumph? Humanity, or the evil Computers?\n"
puts 'Enter your name, valiant Human:'

human_name = gets.chomp
cpu = ComputerPlayer.new
human = HumanPlayer.new(human_name)
game = Game.new

puts "\nLet the game begin!\nYou have 12 rounds to win! or else...\n"
game.play_game(cpu, human)

puts "\nThanks for playing! Bye!\n\n"
