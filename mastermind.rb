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
  attr_accessor :code, :guesses, :name

  def initialize
    @name = 'Computer'
    @code = select_color.sample(4)
    @guesses = []
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
  attr_accessor :name, :guesses, :code

  def initialize(name)
    @name = name
    @guesses = []
    @code = []
  end

  def clear_guesses
    @guesses = []
  end

  def to_s
    "#{@name}'s guesses so far: #{@guesses}"
  end
end

# this class determines all game functions
class Game
  attr_accessor :turns, :winner, :human_choice

  def initialize
    @turns = 0
    @winner = ''
  end

  def win_con(mastermind, guesser)
    if mastermind.code == guesser.guesses
      @winner = guesser.name
      puts "The game lasted for #{@turns + 1} turns."
      @turns = 12
      puts winner_message(guesser)
    elsif human_choice == 'guesser'
      check_match(mastermind, guesser)
    end
  end

  def check_match(mastermind, guesser)
    mastermind.code.select.each_with_index do |color, idx|
      if guesser.guesses[idx] == color
        puts "#{idx + 1}: match #{color}"
      elsif guesser.guesses.include?(color)
        puts "#{color} is part of the code. But in the wrong position."
      end
    end
    not_in_code = guesser.guesses - mastermind.code
    puts "#{not_in_code.join(', ')} not in the code." unless not_in_code.empty?
  end

  def play_game(mastermind, guesser)
    puts "\nThe colors avaible are: #{mastermind.select_color}\n"
    if human_choice == 'guesser'
      puts "You have to guess in what order the colors are in the code.\nThe code consists of 4 colors. Good luck!\n"
    else
      puts "#{mastermind.name}, choose a 4 color code for the computer to guess."
      (1..4).each do |i|
        print "#{i}: "
        mastermind.code.push(gets.chomp.downcase)
      end
    end
    turns_count(mastermind, guesser)
  end

  def turns_count(mastermind, guesser)
    mastermind.shuffle_code if @human_choice == 'guesser'
    @turns = 0
    while @turns < 12
      puts "Turn #{@turns + 1}:"
      round(mastermind, guesser)
      @turns += 1
    end
  end

  def round(mastermind, guesser)
    if human_choice == 'guesser'
      guesser.clear_guesses
      guesses = 0
      puts "\nGuess the 4 colors"
      while guesses < 4
        print "#{guesses + 1}: "
        guesser.guesses.push(gets.chomp.downcase)
        guesses += 1
      end
      puts ''
      win_con(mastermind, guesser)
    else
      computer_guesser(mastermind, guesser)
      puts ''
    end
  end

  def computer_guesser(mastermind, guesser)
    not_in_code = []
    avaible_colors = guesser.colors
    guesser.guesses = avaible_colors.sample(4)
    right_guesses = []
    mastermind.code.select.each do |color|
      if guesser.guesses.include?(color)
        right_guesses.push(color)
      else
        guesser.guesses.each do |e|
          not_in_code.push(e) unless mastermind.code.include?(e)
        end
      end
    end
    puts "RIGHT GUESSES: #{right_guesses}"
    not_in_code.each { |e| avaible_colors.delete(e) }
    guesser.guesses = right_guesses
    win_con(mastermind, guesser)
  end

  def winner_message(guesser)
    human_message = "\n#{guesser.name} wins! Humanity triumphs once again!\n"
    cpu_message = "\nThe computers took over the world and enslaved the human race. Did you really had any chance?\n"

    @winner == 'Computer' ? cpu_message : human_message
  end
end

puts "\nWelcome to the 'Mastermind' game of the century! Who will triumph? Humanity, or the evil Computers?\n"
puts 'Enter your name, valiant Human:'
human_name = gets.chomp
game = Game.new

choice = 'y'
while choice == 'y'
  puts 'Do you want to be Mastermind or Guesser?'
  game.human_choice = gets.chomp.downcase

  if game.human_choice == 'mastermind'
    mastermind = HumanPlayer.new(human_name)
    guesser = ComputerPlayer.new
  else
    mastermind = ComputerPlayer.new
    guesser = HumanPlayer.new(human_name)
  end
  puts "\nLet the game begin!\nYou have 12 rounds to win! or else...\n"
  game.play_game(mastermind, guesser)
  puts 'Do you wanna play again? (Y/N)'
  choice = gets.chomp.downcase
end

puts "\nThanks for playing! Bye!\n\n"
