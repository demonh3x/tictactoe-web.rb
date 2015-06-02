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

    it 'contains the links to the moves' do
      anchors = html.css('[data-board] a')
      links = anchors.map {|anchor| anchor.attributes['href'].value}
      expect(links).to eq([
        '/game/make_move?move=0',
        '/game/make_move?move=1',
        '/game/make_move?move=2',
        '/game/make_move?move=3',
        '/game/make_move?move=4',
        '/game/make_move?move=5',
        '/game/make_move?move=6',
        '/game/make_move?move=7',
        '/game/make_move?move=8'
      ])
    end

    it 'contains a link to restart the game' do
      anchors = html.css('a')
      links = anchors.map {|anchor| anchor.attributes['href'].value}

      expect(links).to include('/game/start')
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

    it 'does not contain the link to the move made' do
      anchors = html.css('[data-board] a')
      links = anchors.map {|anchor| anchor.attributes['href'].value}
      expect(links).not_to include('/game/make_move?move=0')
    end
  end
end
