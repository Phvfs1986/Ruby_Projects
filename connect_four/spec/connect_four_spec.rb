# frozen_string_literal: true

require './lib/connect_four'

RSpec.describe Board do
  describe '#initialize' do
    subject { described_class.new }

    it 'has a 7 x 6 grid' do
      expect(subject.board[0].size).to eq(7)
      expect(subject.board.size).to eq(6)
    end
  end

  describe '#verify_input' do
    subject { described_class.new }

    context 'when given a valid input' do
      it 'returns valid input' do
        valid_input = '3'
        verified_input = subject.verify_input(valid_input)
        expect(verified_input).to eq('3')
      end
    end

    context 'when given an invalid input' do
      it 'returns invalid input' do
        invalid_input = '0'
        verified_input = subject.verify_input(invalid_input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#player_turn' do
    subject { described_class.new }

    context 'when input is valid' do
      it 'stops loop and does not display error' do
        valid_input = '3'
        allow(subject).to receive(:player_input).and_return(valid_input)
        expect(subject).not_to receive(:puts).with('Invalid input!')
        subject.player_turn
      end
    end

    context 'when first input is NOT valid and second input is valid' do
      before do
        valid_input = '3'
        invalid_input = '0'
        allow(subject).to receive(:player_input).and_return(invalid_input, valid_input)
      end

      it 'stops loop and displays error' do
        expect(subject).to receive(:puts).with('Invalid input!').once
        subject.player_turn
      end
    end
  end

  describe '#update_board' do
    subject { described_class.new }

    it 'puts token in the last possible row of chosen column' do
      subject.update_board
      expect(subject.board[5][0]).to eq('X')
    end

    it 'puts token in the last possible row if last row is occupied' do
      subject.update_board
      subject.update_board
      expect(subject.board[4][0]).to eq('X')
    end

    context 'when chosen column is already full' do
      before do
        6.times { subject.update_board }
      end

      it 'prints a message when the column is full' do
        expect { subject.update_board }.to output("Column full!\n").to_stdout
      end
    end
  end

  describe '#game_over' do
    subject { described_class.new }

    context '4 matching tokens vertically' do
      before do
        subject.update_board(0, 1)
        subject.update_board(1, 1)
        subject.update_board(2, 1)
        subject.update_board(3, 1)
      end

      it 'prints a winning message' do
        player = 'X'
        expect { subject.check_vertical }.to output("Winner is #{player}!\n").to_stdout
      end
    end

    context '4 matching tokens horizontally' do
      before do
        subject.update_board(2, 4)
        subject.update_board(2, 5)
        subject.update_board(2, 6)
        subject.update_board(2, 7)
      end

      it 'prints a winning message' do
        player = 'X'
        expect { subject.check_horizontal }.to output("Winner is #{player}!\n").to_stdout
      end
    end

    context '4 matching tokens vertically' do
      before do
        subject.update_board(1, 2)
        subject.update_board(2, 3)
        subject.update_board(3, 4)
        subject.update_board(4, 5)
      end

      it 'prints a winning message' do
        player = 'X'
        expect { subject.check_diagonal }.to output("Winner is #{player}!\n").to_stdout
      end
    end
  end
end
