require 'spec_helper'
require 'rack/test'
require 'nokogiri'
require 'game_stub'
require 'tictactoe/web/endpoints/show_board'
require 'tictactoe/web/templates/erb_template'

RSpec.describe Tictactoe::Web::Endpoints::ShowBoard do
  include Rack::Test::Methods

  module Stub
    class ShowBoard
      attr_accessor :board

      def call()
        board
      end
    end
  end

  let(:use_case)    { Stub::ShowBoard.new }
  let(:template)    { Tictactoe::Web::Templates::ErbTemplate.new(:board) }
  let(:app)         { described_class.new(use_case, template) }
  let(:html)        { get '/game/board'; Nokogiri::HTML(last_response.body) }
  let(:boards)      { html.css('[data-board]') }
  let(:cells)       { html.css('[data-board-cell]') }
  let(:x_cells)     { html.css('[data-board-cell="x"]') }
  let(:links)       { html.css('a').map {|anchor| anchor.attributes['href'].value} }
  let(:cell_links)  { html.css('[data-board-cell] a').map {|anchor| anchor.attributes['href'].value} }

  it 'is mapped to the /game/board route' do
    expect(app.route).to eq '/game/board'
  end

  describe 'given a 3x3 initial board' do
    before(:each) do
      use_case.board = GameStub.new(
        [nil, nil, nil,
         nil, nil, nil,
         nil, nil, nil],
         false,
         nil,
         3,
         :human,
         :human
      )
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
      expect(links).to include('/game/start?board_size=3&x_type=human&o_type=human')
    end

    it 'does not show the winner' do
      expect(html.css('[data-winner]').length).to eq 0
    end
  end

  describe 'given a 4x4 initial board' do
    before(:each) do
      use_case.board = GameStub.new(
        [nil, nil, nil, nil,
         nil, nil, nil, nil,
         nil, nil, nil, nil,
         nil, nil, nil, nil],
         false,
         nil,
         4,
         :human,
         :human
      )
    end

    it 'contains a link to restart the game with board 4' do
      expect(links).to include('/game/start?board_size=4&x_type=human&o_type=human')
    end

    it 'contains the board cells' do
      expect(cells.length).to eq 16
    end
  end

  describe 'given a 3x3 board with one move' do
    before(:each) do
      use_case.board = GameStub.new(
        [:x,  nil, nil,
         nil, nil, nil,
         nil, nil, nil],
         false,
         nil
      )
    end

    it 'shows the move' do
      expect(x_cells.length).to eq 1
    end

    it 'does not contain the link to the move made' do
      expect(cell_links).not_to include('/game/make_move?move=0')
    end
  end

  describe 'given a 3x3 board with x as the winner' do
    before(:each) do
      use_case.board = GameStub.new(
        [:x,  :o,  nil,
         :x,  :o,  nil,
         :x,  nil, nil],
         true,
         :x
      )
    end

    it 'does not contain links to make moves' do
      expect(cell_links).to eq([])
    end

    it 'shows the winner' do
      expect(html.css('[data-winner="x"]').length).to eq 1
    end
  end

  describe 'given a 3x3 board with o as the winner' do
    before(:each) do
      use_case.board = GameStub.new(
        [:x,  :o,  :x,
         :x,  :o,  nil,
         nil, :o,  nil],
         true,
         :o
      )
    end

    it 'shows the winner' do
      expect(html.css('[data-winner="o"]').length).to eq 1
    end
  end

  describe 'given a 3x3 board with a draw' do
    before(:each) do
      use_case.board = GameStub.new(
        [:x,  :o,  :x,
         :x,  :o,  :o,
         :o,  :x,  :x],
         true,
         nil
      )
    end

    it 'shows no winner' do
      expect(html.css('[data-winner="o"]').length).to eq 0
      expect(html.css('[data-winner="x"]').length).to eq 0
      expect(html.css('[data-winner]').length).to eq 1
    end
  end

  describe 'when the computer plays next' do
    before(:each) do
      ready_to_tick = true
      use_case.board = GameStub.new(
        [:x, nil, nil,
         :o, :o, :x,
         :x, :x, :o],
         false,
         nil,
         3,
         :human,
         :computer,
         ready_to_tick
      )
    end

    it 'tells the browser to refresh to game/tick' do
      refresh_metas = html.css('head meta[http-equiv="refresh"]')
      expect(refresh_metas.length).to eq 1
      meta = refresh_metas.first
      expect(meta.attr('content')).to include '/game/tick'
    end
  end
end
