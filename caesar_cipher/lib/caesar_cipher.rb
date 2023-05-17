# frozen_string_literal: true

# cipher class
class Cipher
  attr_reader :string, :shift
  attr_accessor :encoded

  def initialize(string, shift)
    @encoded = ''
    @string = string
    @shift = shift.to_i
    caesar_cipher
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

puts 'Enter text to encode:'
to_encode = gets.chomp
puts 'Enter shift factor:'
shift_factor = gets.chomp

cipher = Cipher.new(to_encode, shift_factor)

puts cipher.encoded
