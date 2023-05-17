# frozen_string_literal: true

# cipher class
class Cipher
  attr_accessor :encoded

  def initialize
    @encoded = ''
  end

  def caesar_cipher(string, shift)
    letters = string.split(//)
    letters.each do |letter|
      @encoded += case letter
                  when /[a-z]/
                    (((letter.ord + shift - 97) % 26) + 97).chr
                  when /[A-Z]/
                    (((letter.ord + shift - 65) % 26) + 65).chr
                  else
                    letter
                  end
    end
    @encoded
  end
end
