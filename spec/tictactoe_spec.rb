require_relative '../app/tictactoe'

describe 'tictactoe' do
  describe 'game' do
  let(:game) { Tictactoe.new() }

    it 'exists' do
      expect(game)
    end

    it 'has nine moves' do
      expect(game.moves_left).to eq(9)
    end

    it 'board can be printed' do
      game.print
    end

    it 'has a status' do
      expect(game.over?).to eq(false)
    end

    context 'when making moves' do
      it 'adds valid to board' do
        expect(game.try_move('1','a','x')).to be true
      end

      it 'rejects invalid input' do
        expect(game.try_move('4','f','x')).to be false
        expect(game.try_move('1',' ','x')).to be false
      end

    end

    it 'has no winning lines' do
      expect(game.cr_win?).to be false

      game.mark(0,0,'X')
      game.mark(0,1,'X')
      game.mark(0,2,'O')
      expect(game.vr_win?).to be false

      game.mark(1,0,'O')
      game.mark(1,1,'X')
      game.mark(1,2,'X')
      expect(game.cr_win?).to be false

      game.mark(2,0,'X')
      game.mark(2,1,'O')
      game.mark(2,2,'O')
      expect(game.cr_win?).to be false
    end

    it 'has winning vertical line' do
      3.times do |k|
        3.times { |i| game.mark(i,k,'X') }
        expect(game.vr_win?).to be true
        game.clear
      end
    end

    it 'has a winning cross line' do
      expect(game.cr_win?).to be false
      game.mark(0,2,'X')
      game.mark(1,1,'O')
      game.mark(2,0,'X')
      expect(game.cr_win?).to be false
      game.mark(1,1,'X')
      expect(game.cr_win?).to be true
    end

    it 'has winning horizontal line' do
      3.times { |i| game.mark(1,i,'X') }
      expect(game.hz_win?).to be true
    end
  end
end
