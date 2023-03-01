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
  end

  def word_generation
    content = File.readlines('google-10000-english-no-swears.txt')
    word = ''
    word = content.sample while word.length <= 5 && word.length <= 12
    word.delete("\n").split('')
  end

  def messages(condition)
    case condition
    when 0
      puts "\nYou already guessed '#{guess}', try again!"
    when 1
      puts "\n'#{guess}' was correct!"
    when 2
      puts "\n'#{guess}' was incorrect!"
    when 3
      puts "\nYou have #{9 - tries} tries left!"
    when 4
      puts "\nYou won! The word was '#{word.join('').capitalize}'"
    when 5
      puts "\nYou guesses #{tries + 1} times! You lose!\nThe word was '#{word.join('').capitalize}'"
    when 6
      print "\nWanna play again? (Y/N): "
    when 7
      puts "\nThanks for playing! Bye!"
    end
  end

  def round
    while tries < 10
      get_input
      win_or_lose
      @tries += 1
    end
    go_again?
  end

  def get_input
    print 'Guess a letter: '
    @guess = gets.chomp.downcase
    while guess_array.include?(guess)
      messages(0)
      print 'Guess a letter: '
      @guess = gets.chomp.downcase
    end
    word.include?(guess) ? messages(1) : messages(2)
    guess_array << guess
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
end

game = Hangman.new
game.round
