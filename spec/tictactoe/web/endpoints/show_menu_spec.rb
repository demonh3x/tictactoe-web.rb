require 'spec_helper'
require 'testable_rack_response'
require 'tictactoe/web/endpoints/show_menu'

RSpec.describe Tictactoe::Web::Endpoints::ShowMenu do
  let(:menu)         { described_class.new }
  let(:environment)  { {} }
  let(:response)     { TestableRackResponse.new(menu.call(environment)) }

  it 'is mapped to the root route' do
    expect(menu.route).to eq '/'
  end

  it 'responds successfully' do
    expect(response.status).to eq 200
  end

  it 'responds with the appropriate headers' do
    expect(response.headers).to eq({
      "Content-Length" => response.body.length.to_s
    })
  end

  it 'contains the links for the board size options' do
    expect(response.body).to include('/game/start?board_size=3')
    expect(response.body).to include('/game/start?board_size=4')
  end
end
