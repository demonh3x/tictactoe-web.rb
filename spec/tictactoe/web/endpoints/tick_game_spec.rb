require 'spec_helper'
require 'rack/test'
require 'tictactoe/web/endpoints/tick_game'

RSpec.describe Tictactoe::Web::Endpoints::TickGame do
  include Rack::Test::Methods

  module Spy
    class TickGameUseCase
      def call
        @called = true
      end

      def has_been_called?
        @called
      end
    end
  end

  let(:use_case)         { Spy::TickGameUseCase.new }
  let(:show_board_route) { '/game/board' }
  let(:app)              { described_class.new(use_case, show_board_route) }

  it 'is mapped to the /game/tick route' do
    expect(app.route).to eq '/game/tick'
  end

  it 'redirects to the show board route' do
    get '/game/tick'
    expect(last_response).to be_redirect
    expect(last_response.location).to eq '/game/board'
  end

  it 'calls the use case' do
    get '/game/tick'
    expect(use_case).to have_been_called
  end
end
