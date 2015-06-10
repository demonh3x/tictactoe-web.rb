require 'spec_helper'
require 'tictactoe/use_cases/start_game'

RSpec.describe Tictactoe::UseCases::StartGame do
  class GameSpy
    def initialize(factory, board_size, x_type, o_type)
      @factory = factory
      @board_size = board_size
      @x_type = x_type
      @o_type = o_type
    end

    attr_reader :factory, :board_size, :x_type, :o_type
  end

  let(:game_class)      { GameSpy }
  let(:game_repository) { {} }
  let(:use_case)        { described_class.new(game_repository, game_class) }

  def start_game(board_size, x_type, o_type)
    use_case.call(board_size, x_type, o_type)
  end

  it 'creates a game' do
    start_game(3, :human, :human)
    expect(game_repository[:game]).to be_an_instance_of game_class
  end

  describe 'creates the game with the board size, for example:' do
    it '3x3 board' do
      start_game(3, :human, :human)
      expect(game_repository[:game].board_size).to eq 3
    end

    it '4x4 board' do
      start_game(4, :human, :human)
      expect(game_repository[:game].board_size).to eq 4
    end
  end

  describe 'creates the game with the players, for example:' do
    it 'x as human' do
      start_game(3, :human, :computer)
      expect(game_repository[:game].x_type).to eq :human
    end

    it 'o as human' do
      start_game(3, :computer, :human)
      expect(game_repository[:game].o_type).to eq :human
    end

    it 'x as computer' do
      start_game(3, :computer, :human)
      expect(game_repository[:game].x_type).to eq :computer
    end

    it 'o as computer' do
      start_game(3, :human, :computer)
      expect(game_repository[:game].o_type).to eq :computer
    end
  end

  it 'adds the players factory' do
    start_game(3, :human, :human)
    expect(game_repository[:game].factory).not_to be_nil
  end

  it 'the moves are wired to the human players' do
    start_game(3, :human, :human)
    game_repository[:moves] << 5
    human = game_repository[:game].factory.create(:human, :x)
    move = human.get_move(:ignored_state)
    expect(move).to eq 5
  end
end
