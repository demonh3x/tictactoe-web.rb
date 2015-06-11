require 'spec_helper'
require 'rack/test'
require 'tictactoe/web/endpoints/make_move'

RSpec.describe Tictactoe::Web::Endpoints::MakeMove do
  include Rack::Test::Methods

  module Spy
    class MakeMoveUseCase
      def call(move)
        @move = move
      end

      attr_reader :move
    end
  end

  let(:use_case)         { Spy::MakeMoveUseCase.new }
  let(:show_board_route) { '/game/board' }
  let(:app)              { described_class.new(use_case, show_board_route) }

  it 'is mapped to the /game/make_move route' do
    expect(app.route).to eq '/game/make_move'
  end

  it 'redirects to the show board route' do
    get '/game/make_move?move=3'
    expect(last_response).to be_redirect
    expect(last_response.location).to eq '/game/board'
  end

  it 'parses the move and sends it to the use case' do
    get '/game/make_move?move=3'
    expect(use_case.move).to eq 3
  end

  it 'responds bad request when the move is missing' do
    get '/game/make_move'
    expect(last_response.status).to eq 400
  end

  it 'responds bad request when the move is not an integer' do
    get '/game/make_move?move=a'
    expect(last_response.status).to eq 400
  end
end
