require 'spec_helper'
require 'game_tick_spy'
require 'tictactoe/use_cases/make_move'

RSpec.describe Tictactoe::UseCases::MakeMove do
  class MovesSpy
    def <<(move)
      @received_move = move
    end

    attr_reader :received_move
  end

  let(:moves)           { MovesSpy.new }
  let(:game)            { GameTickSpy.new }
  let(:game_repository) { {:game => game, :moves => moves} }
  let(:make_move)       { described_class.new(game_repository) }

  it 'sends the move to game' do
    make_move.call(4)
    expect(moves.received_move).to eq(4)
  end

  it 'calls tick on the game' do
    make_move.call(2)
    expect(game).to have_been_ticked
  end
end
