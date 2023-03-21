# frozen_string_literal: true

require 'yaml'

# all functionality is in this class. Will refactor better later.
class Hangman
  attr_accessor :guess, :guess_array, :word, :tries

  def initialize
    @guess_array = []
    @guess = ''
    @word = word_generation
    @tries = 0
    round
  end

  def word_generation
    content = File.readlines('google-10000-english-no-swears.txt')
    word = ''
    word = content.sample while word.length <= 5 && word.length <= 12
    word.strip!.split('')
  end

  def messages(condition)
    case condition
    when 0 then puts "\nYou already guessed '#{guess}', try again!"
    when 1 then puts "\n'#{guess}' was correct!"
    when 2 then puts "\n'#{guess}' was incorrect!"
    when 3 then puts "\nYou have #{9 - tries} tries left!"
    when 4 then puts "\nYou won! The word was '#{word.join('').capitalize}'"
    when 5 then puts "\nYou guesses #{tries + 1} times! You lose!\nThe word was '#{word.join('').capitalize}'"
    when 6 then print "\nWanna play again? (Y/N): "
    when 7 then puts "\nThanks for playing! Bye!"
    end
  end

  def menu(selection)
    case selection
    when '1' then puts 'Game Start!'
    when '2'
      puts 'Game Loaded!'
      load_game
    end
  end

  def round
    puts "Please select an option:\n1: New Game\n2: Load Game"
    selection = gets.chomp.downcase
    menu(selection)
    while tries < 10
      get_input
      win_or_lose
      @tries += 1
    end
    go_again?
  end

  def get_input
    print "Guess a letter (or write 'SAVE' to save your game): "
    @guess = gets.chomp.downcase
    save_game if @guess == 'save'
    while guess_array.include?(guess)
      messages(0)
      print "Guess a letter (or write 'SAVE' to save your game): "
      @guess = gets.chomp.downcase
    end
    guess_array << guess
    word.include?(guess) ? messages(1) : messages(2)
  end

  def win_or_lose
    if (word - guess_array).empty?
      @tries = 10
      messages(4)
      return
    elsif @tries == 9
      messages(5)
      return
    end
    messages(3)
    reveal_or_not
  end

  def reveal_or_not
    word.each do |char|
      if guess_array.include?(char)
        print char
      else
        print '_ '
      end
    end
    puts ''
  end

  def go_again?
    messages(6)
    choice = gets.chomp.downcase
    if choice == 'y'
      reset_game
    else
      messages(7)
    end
  end

  def reset_game
    @tries = 0
    @guess = ''
    @guess_array = []
    @word = word_generation
    round
  end

  def save_game
    puts 'Game saved!'
    File.open('hangman.yml', 'w') { |file| file.write save_to_yaml }
    get_input
  end

  def save_to_yaml
    YAML.dump(
      'guess_array' => @guess_array,
      'guess' => @guess,
      'word' => @word,
      'tries' => @tries
    )
  end

  def load_game
    file = YAML.safe_load(File.read('hangman.yml'))
    @guess_array = file['guess_array']
    @guess = file['guess']
    @word = file['word']
    @tries = file['tries']
    load_game_help
  end

  def load_game_help
    puts 'Details from last game:'
    puts "Guesses: #{guess_array}"
    puts "Turns: #{tries}"
    puts 'Secret word:'
    reveal_or_not
  end
end

Hangman.new
