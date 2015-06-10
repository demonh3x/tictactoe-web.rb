require 'spec_helper'
require 'tictactoe/use_cases/show_board'

RSpec.describe Tictactoe::UseCases::ShowBoard do
  let(:game)            { :current_game }
  let(:game_repository) { {:game => game} }
  let(:show_board)      { described_class.new(game_repository) }

  it 'returns the game state' do
    expect(show_board.call).to eq game
  end
end
