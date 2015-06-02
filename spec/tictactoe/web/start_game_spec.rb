require 'spec_helper'
require 'tictactoe/web/start_game'

RSpec.describe Tictactoe::Web::StartGame do
  class GameSpy
    def initialize(board_size, x_type, o_type)
      @board_size = board_size
      @x_type = x_type
      @o_type = o_type
    end

    def register_human_factory(factory)
      @human_factory = factory
    end

    attr_reader :board_size, :x_type, :o_type, :human_factory
  end

  let(:game_class)   { GameSpy }
  let(:game_gateway) { {} }
  let(:start_game)   { described_class.new(game_gateway, game_class) }

  before(:each) do
    start_game.call()
    @game = game_gateway[:game]
    @moves = game_gateway[:moves]
  end

  it 'creates a game' do
    expect(@game).to be_an_instance_of game_class
  end

  it 'creates the game with the 3x3 board' do
    expect(@game.board_size).to eq 3
  end

  it 'creates the game with human vs human' do
    expect(@game.x_type).to eq :human
    expect(@game.o_type).to eq :human
  end

  it 'adds a human factory' do
    expect(@game.human_factory).not_to be_nil
  end

  it 'the moves are wired to the human players' do
    @moves << 5
    human = @game.human_factory.call(:x)
    move = human.get_move(:ignored_state)
    expect(move).to eq 5
  end
end
