# frozen_string_literal: true

require_relative '../app/tictactoe'

RSpec.describe 'tictactoe' do
  describe 'game' do
    let(:game) { Tictactoe.new }

    context 'when creating a new one it' do
      it 'exists' do
        expect(game)
      end

      it 'has nine moves' do
        expect(game.moves_left).to eq(9)
      end

      it 'has a printable board' do
        expect(game.printable_board).to be_an(Array)
        expect(game.printable_board[2]).to match /0  | |/
      end

      it 'has a status' do
        expect(game.over?).to eq(false)
      end
    end

    context 'when making moves it' do
      it 'adds valid ones to board' do
        expect(game.try_move('1', 'a',)).to be true
      end

      it 'rejects invalid input' do
        expect(game.try_move('4', 'f')).to be false
        expect(game.try_move('1', ' ')).to be false
      end
    end

    context 'has rules to know when it' do
      it 'has no winning lines' do
        expect(game.cr_win?).to be false

        game.mark(0, 0, 'X')
        game.mark(0, 1, 'X')
        game.mark(0, 2, 'O')
        expect(game.vr_win?).to be false

        game.mark(1, 0, 'O')
        game.mark(1, 1, 'X')
        game.mark(1, 2, 'X')
        expect(game.cr_win?).to be false

        game.mark(2, 0, 'X')
        game.mark(2, 1, 'O')
        game.mark(2, 2, 'O')
        expect(game.cr_win?).to be false
      end

      it 'has winning vertical line' do
        3.times do |k|
          3.times { |i| game.mark(i, k, 'X') }
          expect(game.vr_win?).to be true
          game.clear
        end
      end

      it 'has a winning cross line' do
        game.mark(0, 2, 'X')
        game.mark(1, 1, 'X')
        game.mark(2, 0, 'X')
        expect(game.cr_win?).to be true
      end

      it 'has winning horizontal line' do
        3.times { |i| game.mark(1, i, 'X') }
        expect(game.hz_win?).to be true
      end
    end
  end
end
