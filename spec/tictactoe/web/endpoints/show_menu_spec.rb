require 'spec_helper'
require 'rack/test'
require 'tictactoe/web/endpoints/show_menu'

RSpec.describe Tictactoe::Web::Endpoints::ShowMenu do
  include Rack::Test::Methods

  let(:app)          { described_class.new }
  let(:environment)  { {} }
  let(:response)     { get '/'; last_response }

  it 'is mapped to the root route' do
    expect(app.route).to eq '/'
  end

  it 'responds successfully' do
    expect(response.status).to eq 200
  end

  it 'contains the links for the board size options' do
    expect(response.body).to include('/game/start?board_size=3')
    expect(response.body).to include('/game/start?board_size=4')
  end
end
