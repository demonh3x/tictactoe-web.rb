require 'spec_helper'
require 'rack/test'
require 'tictactoe/web/endpoints/start_game'

RSpec.describe Tictactoe::Web::Endpoints::StartGame do
  include Rack::Test::Methods

  module Spy
    class StartGameUseCase
      def call(board_size, x_type, o_type)
        @board_size = board_size
        @x_type = x_type
        @o_type = o_type
      end

      attr_reader :board_size, :x_type, :o_type
    end
  end

  module Stub
    class Endpoint
      def initialize(route)
        @route = route
      end

      attr_reader :route
    end
  end

  let(:use_case)         { Spy::StartGameUseCase.new }
  let(:show_board_route) { '/game/board' }
  let(:app)              { described_class.new(use_case, show_board_route) }

  it 'is mapped to the /game/start route' do
    expect(app.route).to eq '/game/start'
  end

  it 'redirects to the show board route' do
    get '/game/start?board_size=3&x_type=human&o_type=human'
    expect(last_response).to be_redirect
    expect(last_response.location).to eq '/game/board'
  end

  describe 'parses the board size and sends it to the use case, for example:' do
    it 'size 3' do
      get '/game/start?board_size=3&x_type=human&o_type=human'
      expect(use_case.board_size).to eq 3
    end

    it 'size 4' do
      get '/game/start?board_size=4&x_type=human&o_type=human'
      expect(use_case.board_size).to eq 4
    end
  end

  describe 'parses the players and sends it to the use case, for example:' do
    it 'x being human' do
      get '/game/start?board_size=3&x_type=human&o_type=computer'
      expect(use_case.x_type).to eq :human
    end

    it 'x being computer' do
      get '/game/start?board_size=3&x_type=computer&o_type=human'
      expect(use_case.x_type).to eq :computer
    end

    it 'o being human' do
      get '/game/start?board_size=3&x_type=computer&o_type=human'
      expect(use_case.o_type).to eq :human
    end

    it 'o being computer' do
      get '/game/start?board_size=3&x_type=human&o_type=computer'
      expect(use_case.o_type).to eq :computer
    end
  end

  describe 'responds bad request when one argument is missing, for example' do
    it 'the board size' do
      get '/game/start?x_type=human&o_type=human'
      expect(last_response.status).to eq 400
    end

    it 'the x player' do
      get '/game/start?board_size=3&o_type=human'
      expect(last_response.status).to eq 400
    end

    it 'the o player' do
      get '/game/start?board_size=3&x_type=human'
      expect(last_response.status).to eq 400
    end
  end

  describe 'responds bad request when the board size is not valid, for example:' do
    it 'non-integer' do
      get '/game/start?board_size=a&x_type=human&o_type=human'
      expect(last_response.status).to eq 400
    end

    it 'less than the minimum size' do
      get '/game/start?board_size=2&x_type=human&o_type=human'
      expect(last_response.status).to eq 400
    end

    it 'more than the maximum size' do
      get '/game/start?board_size=5&x_type=human&o_type=human'
      expect(last_response.status).to eq 400
    end
  end

  describe 'responds bad request when one of the players is not valid, for example:' do
    it 'x player is invalid' do
      get '/game/start?board_size=3&x_type=invalid&o_type=human'
      expect(last_response.status).to eq 400
    end

    it 'o player is invalid' do
      get '/game/start?board_size=3&x_type=human&o_type=invalid'
      expect(last_response.status).to eq 400
    end
  end
end
