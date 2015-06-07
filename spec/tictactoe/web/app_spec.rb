require 'spec_helper'
require 'tictactoe/web/app'
require 'rack/test'
require 'nokogiri'

describe Tictactoe::Web::App do
  include Rack::Test::Methods

  let(:app)        { Rack::Builder.parse_file('config.ru').first }
  let(:html)       { Nokogiri::HTML(last_response.body) }

  describe 'when x wins the game' do
    def make_moves(*moves)
      moves.each do |move|
        get '/game/make_move', params={:move => move}
        follow_redirect!
      end
    end

    before(:each) do
      get '/game/start?board_size=3'
      make_moves(0, 1, 3, 4, 6)
    end

    it 'shows the winner' do
      expect(html.css('[data-winner="x"]').length).to eq 1
    end
  end
end
