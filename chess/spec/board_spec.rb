# frozen_string_literal: true

require './lib/board'

RSpec.describe Board do
  describe '#initialize' do
    it 'create a 8x8 grid' do
      expect(subject.grid).to eq(Array.new(8) { Array.new(8) { '.' } })
    end
  end

  describe '#put_piece' do
    it 'puts piece in correct location' do
      subject.put_piece([0, 0], 'P')
      expect(subject.grid[0][0]).to eq('P')
    end
  end

  describe '#piece_at' do
    it 'returns correct piece at location' do
      subject.put_piece([0, 0], 'P')
      expect(subject.piece_at([0, 0])).to eq('P')
    end
  end

  describe '#in_bounds?' do
    it 'returns true' do
      expect(subject.in_bounds?([5, 5])).to eq(true)
    end

    it 'returns false' do
      expect(subject.in_bounds?([9, 9])).to eq(false)
    end
  end

  describe '#empty?' do
    before do
      subject.put_piece([0, 0], 'P')
    end
    it 'returns true' do
      expect(subject.empty?([1, 1])).to eq(true)
    end

    it 'returns false' do
      expect(subject.empty?([0, 0])).to eq(false)
    end
  end

  describe '#pieces' do
    it 'returns an empty array' do
      expect(subject.pieces).to eq([])
    end

    it 'returns array with one element' do
      subject.put_piece([0, 0], 'P')
      expect(subject.pieces.length).to be(1)
    end
  end
end
