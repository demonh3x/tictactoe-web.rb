require 'spec_helper'
require 'rack/test'
require 'tictactoe/web/endpoints/start_game'

RSpec.describe Tictactoe::Web::Endpoints::StartGame do
  include Rack::Test::Methods

  module Spy
    class StartGameUseCase
      def call(board_size)
        @board_size = board_size
      end

      attr_reader :board_size
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

  let(:use_case)    { Spy::StartGameUseCase.new }
  let(:show_board)  { Stub::Endpoint.new('/game/board') }
  let(:app)         { described_class.new(use_case, show_board) }

  it 'is mapped to the /game/start route' do
    expect(app.route).to eq '/game/start'
  end

  it 'redirects to the show board route' do
    get '/game/start?board_size=3'
    expect(last_response).to be_redirect
    expect(last_response.location).to eq '/game/board'
  end

  it 'parses the board size and sends it to the use case' do
    get '/game/start?board_size=3'
    expect(use_case.board_size).to eq 3
  end

  it 'responds bad request when the board size is missing' do
    get '/game/start'
    expect(last_response.status).to eq 400
  end

  describe 'responds bad request when the board size is not valid, for example:' do
    it 'non-integer' do
      get '/game/start?board_size=a'
      expect(last_response.status).to eq 400
    end

    it 'less than the minimum size' do
      get '/game/start?board_size=2'
      expect(last_response.status).to eq 400
    end

    it 'more than the maximum size' do
      get '/game/start?board_size=5'
      expect(last_response.status).to eq 400
    end
  end
end
