require 'tictactoe/web/app'
require 'rack/test'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app) { described_class.new }

  describe 'when starting a game' do
    before(:each) do
      post '/game/start'
      follow_redirect!
    end

    it 'succeeds' do
      expect(last_response).to be_ok
    end

    it 'contains the board' do
      expect(last_response.body).to include('data-id="board"')
    end
  end
end
