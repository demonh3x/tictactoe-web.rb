require 'spec_helper'
require 'tictactoe/web/app'
require 'rack/test'
require 'nokogiri'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app)        { Rack::Builder.parse_file('config.ru').first }
  let(:html)       { Nokogiri::HTML(last_response.body) }
  let(:boards)     { html.css('[data-board]') }
  let(:cells)      { html.css('[data-board-cell]') }
  let(:x_cells)    { html.css('[data-board-cell="x"]') }
  let(:links)      { html.css('a').map {|anchor| anchor.attributes['href'].value} }
  let(:cell_links) { html.css('[data-board-cell] a').map {|anchor| anchor.attributes['href'].value} }

  describe 'when starting a game with board size 3' do
    before(:each) do
      get '/game/start?board_size=3'
      follow_redirect!
    end

    it 'succeeds' do
      expect(last_response).to be_ok
    end

    it 'contains a board' do
      expect(boards.length).to eq 1
    end

    it 'contains the board cells' do
      expect(cells.length).to eq 9
    end

    it 'contains the links to the moves' do
      expect(cell_links).to eq([
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
      expect(links).to include('/game/start?board_size=3')
    end
  end

  describe 'when starting a game with board size 4' do
    before(:each) do
      get '/game/start?board_size=4'
      follow_redirect!
    end

    it 'contains a link to restart the game with board 4' do
      expect(links).to include('/game/start?board_size=4')
    end

    it 'contains the board cells' do
      expect(cells.length).to eq 16
    end
  end

  describe 'when making a move' do
    before(:each) do
      get '/game/start?board_size=3'
      get '/game/make_move', params={:move => 0}
      follow_redirect!
    end

    it 'succeeds' do
      expect(last_response).to be_ok
    end

    it 'shows the move' do
      expect(x_cells.length).to eq 1
    end

    it 'does not contain the link to the move made' do
      expect(cell_links).not_to include('/game/make_move?move=0')
    end
  end

  describe 'when starting a game with board size 4' do
    before(:each) do
      get '/game/start?board_size=4'
      follow_redirect!
    end

    it 'contains the board cells' do
      expect(cells.length).to eq 16
    end
  end

  describe 'the menu' do
    before(:each) do
      get '/'
    end

    it 'contains a link to start a game with board size 3' do
      expect(links).to include('/game/start?board_size=3')
    end

    it 'contains a link to start a game with board size 4' do
      expect(links).to include('/game/start?board_size=4')
    end
  end
end
