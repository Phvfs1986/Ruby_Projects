# frozen_string_literal: true

require_relative '../lib/caesar_cipher'

RSpec.describe Cipher do
  describe '#initialize' do
    it 'sets the string and shift values' do
      cipher = Cipher.new('Hello, World!', 3)
      expect(cipher.string).to eq('Hello, World!')
      expect(cipher.shift).to eq(3)
    end
  end

  describe '#caesar_cipher' do
    it 'returns lowercase correctly' do
      cipher = Cipher.new('hello', 2)
      expect(cipher.encoded).to eq('jgnnq')
    end

    it 'returns uppercase correctly' do
      cipher = Cipher.new('WORLD', 4)
      expect(cipher.encoded).to eq('ASVPH')
    end

    it 'returns non-alphabetic characters unchanged' do
      cipher = Cipher.new('Hello, World!', 3)
      expect(cipher.encoded).to eq('Khoor, Zruog!')
    end
  end
end
