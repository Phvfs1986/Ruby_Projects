# frozen_string_literal: true

require './lib/caesar_cipher'

describe Cipher do
  subject { Cipher.new }

  describe '#caesar_cipher' do
    it 'Returns the correct rotation' do
      expect(subject.caesar_cipher('harry', 5)).to eql 'mfwwd'
    end

    it 'returns upper/lower cases' do
      expect(subject.caesar_cipher('HARRY', 5)).to eql 'MFWWD'
    end

    it 'returns only spaces' do
      expect(subject.caesar_cipher('     ', 5)).to eql '     '
    end

    it 'returns combination of upper + lower cases' do
      expect(subject.caesar_cipher('HaRrY', 5)).to eql 'MfWwD'
    end

    it 'returns letters + numbers combination' do
      expect(subject.caesar_cipher('harry123', 5)).to eql 'mfwwd123'
    end
  end
end
