# frozen_string_literal: true

require './lib/board'

RSpec.describe Board do
  let(:player_one) { double(name: 'Jack', symbol: 'X') }
  let(:player_two) { double(name: 'Mary', symbol: 'O') }

  before do
    allow(Player).to receive(:new).and_return(player_one, player_two)
  end

  subject { described_class.new }

  describe '#initialize' do
    it 'board has a 7 x 6 grid' do
      expect(subject.board[0].size).to eq(7)
      expect(subject.board.size).to eq(6)
    end

    it 'creates two players' do
      allow(player_one).to receive(:instance_of?).with(Player).and_return(true)
      allow(player_two).to receive(:instance_of?).with(Player).and_return(true)

      expect(player_one).to be_instance_of(Player)
      expect(player_two).to be_instance_of(Player)
    end

    it 'stores the correct name and symbol for each player' do
      expect(subject.instance_variable_get(:@player_one).name).to eq('Jack')
      expect(subject.instance_variable_get(:@player_one).symbol).to eq('X')
      expect(subject.instance_variable_get(:@player_two).name).to eq('Mary')
      expect(subject.instance_variable_get(:@player_two).symbol).to eq('O')
    end
  end

  describe '#update_board' do
    let(:row) { 5 }
    let(:verified_input) { 1 }
    let(:actual_player) { player_one }

    it 'puts token in the last possible row of chosen column' do
      subject.update_board(row, verified_input, actual_player)
      expect(subject.board[5][0]).to eq('X')
    end

    it 'puts token in the last possible row if last row is occupied' do
      subject.update_board(row, verified_input, actual_player)
      subject.update_board(row, verified_input, actual_player)
      expect(subject.board[4][0]).to eq('X')
    end

    context 'when chosen column is already full' do
      before do
        6.times { subject.update_board(row, verified_input, actual_player) }
      end

      it 'prints a message when the column is full' do
        expect { subject.update_board(row, verified_input, actual_player) }.to output("Column full!\n").to_stdout
      end
    end
  end
end
