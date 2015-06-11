require 'spec_helper'
require 'tictactoe/web/app'
require 'rack/test'
require 'nokogiri'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app)  { Rack::Builder.parse_file('config.ru').first }
  def html
    Nokogiri::HTML(last_response.body)
  end

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

  def follow_refresh!
    refresh = html.css('head meta[http-equiv="refresh"]').first
    url = refresh.attr('content').split('url=')[1]
    get url
  end

  describe 'given a full game with two computers' do
    before(:each) do
      get '/game/start?board_size=3&x_type=computer&o_type=computer'
      follow_redirect!
    end

    it 'ends in a draw' do
      9.times do
        follow_refresh!
        follow_redirect!
        expect(last_response).to be_ok
      end
      expect(html.css('[data-winner=""]').length).to eq 1
    end
  end
end
