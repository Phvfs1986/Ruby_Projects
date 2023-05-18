# frozen_string_literal: true

# cipher class
class Cipher
  attr_reader :string, :shift
  attr_accessor :encoded

  def initialize
    @encoded = ''
    @string = ''
    @shift = 0
    start
  end

  def start
    take_input
    caesar_cipher
    print 'Encoded message: '
    puts @encoded
  end

  def take_input
    print 'Enter text to encode: '
    @string = gets.chomp
    print 'Enter shift factor: '
    @shift = gets.chomp.to_i
  end

  def caesar_cipher
    string.each_char do |letter|
      @encoded += case letter
                  when /[a-z]/
                    shift_character(letter, 97)
                  when /[A-Z]/
                    shift_character(letter, 65)
                  else
                    letter
                  end
    end
  end

  def shift_character(char, ascii_value)
    (((char.ord + @shift - ascii_value) % 26) + ascii_value).chr
  end
end

Cipher.new
