# frozen_string_literal: true

require './lib/game'

RSpec.describe Game do
  describe '#verify_input' do
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
    context 'when input is valid' do
      it 'stops loop and does not display error' do
        valid_input = '3'
        allow(subject).to receive(:player_input).with(:player).and_return(valid_input)
        expect(subject).not_to receive(:puts).with('Invalid input!')
        subject.player_turn(:player)
      end
    end

    context 'when first input is NOT valid and second input is valid' do
      before do
        valid_input = '3'
        invalid_input = '0'
        allow(subject).to receive(:player_input).with(:player).and_return(invalid_input, valid_input)
      end

      it 'stops loop and displays error' do
        expect(subject).to receive(:puts).with('Invalid input!').once
        subject.player_turn(:player)
      end
    end
  end

  describe '#game_over' do
    context '4 matching tokens horizontally' do
      it 'returns true' do
        board = %w[. . . . . . .],
                %w[. . . . . . .],
                %w[. . . . . . .],
                %w[. . . . . . .],
                %w[. . . . . . .],
                %w[X X X X . . .]

        expect(subject.win_con(board)).to eq(true)
      end
    end

    context '4 matching tokens horizontally' do
      it 'returns true' do
        board = %w[. . . . . . .],
                %w[. . . . . . .],
                %w[X . . . . . .],
                %w[X . . . . . .],
                %w[X . . . . . .],
                %w[X . . . . . .]

        expect(subject.win_con(board.transpose)).to eq(true)
      end
    end

    context '4 matching tokens diagonally' do
      it 'returns true' do
        board = %w[. . . . . . .],
                %w[. . . . . . .],
                %w[X . . . . . .],
                %w[. X . . . . .],
                %w[. . X . . . .],
                %w[. . . X . . .]

        diagonal = subject.check_diagonal(board)
        expect(subject.win_con(diagonal)).to eq(true)
      end
    end

    context '4 matching tokens ante-diagonally' do
      it 'returns true' do
        board = %w[. . . . . . .],
                %w[. . . . . . .],
                %w[. . . X . . .],
                %w[. . X . . . .],
                %w[. X . . . . .],
                %w[X . . . . . .]

        diagonal_inverse = subject.diagonal_inverse(board)
        diagonal = subject.check_diagonal(diagonal_inverse)
        expect(subject.win_con(diagonal)).to eq(true)
      end
    end
  end
end
