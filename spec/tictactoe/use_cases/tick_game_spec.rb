require 'spec_helper'
require 'tictactoe/use_cases/tick_game'

RSpec.describe Tictactoe::UseCases::TickGame do
  let(:game)            { GameTickSpy.new }
  let(:game_repository) { {:game => game} }
  let(:tick_game)       { described_class.new(game_repository) }

  it 'calls tick on the game' do
    tick_game.call
    expect(game).to have_been_ticked
  end
end
