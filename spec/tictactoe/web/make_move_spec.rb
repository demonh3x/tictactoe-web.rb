require 'tictactoe/web/make_move'

RSpec.describe Tictactoe::Web::MakeMove do
  class MovesSpy
    def <<(move)
      @received_move = move
    end

    attr_reader :received_move
  end

  class GameTickSpy
    def tick
      @has_tick_been_called = true
    end

    def has_been_ticked?
      @has_tick_been_called
    end
  end

  let(:moves)        { MovesSpy.new }
  let(:game)         { GameTickSpy.new }
  let(:game_gateway) { {:game => game, :moves => moves} }
  let(:make_move)    { described_class.new(game_gateway) }

  it 'sends the move to game' do
    make_move.call(4)
    expect(moves.received_move).to eq(4)
  end

  it 'calls tick on the game' do
    make_move.call(2)
    expect(game).to have_been_ticked
  end
end
