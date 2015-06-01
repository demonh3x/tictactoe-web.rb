require 'tictactoe/web/app'
require 'rack/test'
require 'nokogiri'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app)  { Rack::Builder.parse_file('config.ru').first }
  let(:html) { Nokogiri::HTML(last_response.body) }

  describe 'when starting a game' do
    before(:each) do
      get '/game/start'
      follow_redirect!
    end

    it 'succeeds' do
      expect(last_response).to be_ok
    end

    it 'contains a board' do
      expect(html.css('[data-board]').length).to eq 1
    end

    it 'contains the board cells' do
      expect(html.css('[data-board-cell]').length).to eq 9
    end
  end

  describe 'when making a move' do
    before(:each) do
      get '/game/start'
      get '/game/make_move', params={:move => 0}
      follow_redirect!
    end

    it 'succeeds' do
      expect(last_response).to be_ok
    end

    it 'shows the move' do
      expect(html.css('[data-board-cell="x"]').length).to eq 1
    end
  end
end
