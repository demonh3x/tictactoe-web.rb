require 'spec_helper'
require 'tictactoe/use_cases/show_board'

RSpec.describe Tictactoe::UseCases::ShowBoard do
  class GameStub
    def initialize(state)
      @state = state
    end

    attr_reader :state
  end

  let(:game)            { GameStub.new(:state) }
  let(:game_repository) { {:game => game} }
  let(:show_board)      { described_class.new(game_repository) }

  it 'returns the game state' do
    expect(show_board.call).to eq game.state
  end
end
