require 'spec_helper'
require 'tictactoe/web/app'
require 'rack/test'
require 'nokogiri'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app)  { Rack::Builder.parse_file('config.ru').first }
  let(:html) { Nokogiri::HTML(last_response.body) }

  describe 'when x wins the game' do
    def make_moves(*moves)
      moves.each do |move|
        get '/game/make_move', params={:move => move}
        follow_redirect!
      end
    end

    before(:each) do
      get '/game/start?board_size=3&x_type=human&o_type=human'
      make_moves(0, 1, 3, 4, 6)
    end

    it 'shows the winner' do
      expect(html.css('[data-winner="x"]').length).to eq 1
    end
  end

  it 'shows the menu with the options' do
    get '/'
    expect(html.css('input[value="3"][name="board_size"]').length).to eq 1
    expect(html.css('input[value="human"][name="x_type"]').length).to eq 1
    expect(html.css('input[value="computer"][name="o_type"]').length).to eq 1
  end

  describe 'given a game with two computers' do
    before(:each) do
      get '/game/start?board_size=3&x_type=computer&o_type=computer'
      follow_redirect!
    end

    it 'has an automatic redirect in the first move' do
      refresh_metas = html.css('head meta[http-equiv="refresh"]')
      expect(refresh_metas.length).to eq 1
    end
  end
end
