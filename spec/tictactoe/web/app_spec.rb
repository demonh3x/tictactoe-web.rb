require 'tictactoe/web/app'
require 'rack/test'
require 'nokogiri'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app)  { described_class.new }
  let(:html) { Nokogiri::HTML(last_response.body) }

  describe 'when starting a game' do
    before(:each) do
      post '/game/start'
      follow_redirect!
    end

    it 'succeeds' do
      expect(last_response).to be_ok
    end

    it 'contains a board' do
      expect(html.css('[data-board]').length).to be 1
    end

    it 'contains the board cells' do
      expect(html.css("[data-board-cell]").length).to eq 9
    end
  end
end
