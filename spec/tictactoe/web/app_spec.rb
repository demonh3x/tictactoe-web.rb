require 'tictactoe/web/app'
require 'browser'
require 'environment'

RSpec.describe Tictactoe::Web::App do
  let(:app)      { described_class.new }
  let(:browser)  { Server::Browser.new(app) }
  let(:env)      { Server::Environment.new }
  let(:response) { browser.get_response(env.hash) }
  
  xit 'can start a game' do
    env.set_uri('/start')
    expect(response.code).to eq 200
    expect(response.data).to eq({
      "marks" => [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ],
      "is_finished" => false,
      "winner" => nil,
      "available_moves" => [0, 1, 2, 3, 4, 5, 6, 7, 8]
    })
  end

  xit 'can go to the next step' do
    env.set_uri('/start/0')
    expect(response.code).to eq 200
    expect(response.data).to eq({
      "marks" => [
        "x", nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ],
      "is_finished" => false,
      "winner" => nil,
      "available_moves" => [1, 2, 3, 4, 5, 6, 7, 8]
    })
  end

  xit 'can get to a finished game' do
    env.set_uri('/start/0/1/3/4/6')
    expect(response.code).to eq 200
    expect(response.data).to eq({
      "marks" => [
        "x", "o", nil,
        "x", "o", nil,
        "x", nil, nil,
      ],
      "is_finished" => true,
      "winner" => "x",
      "available_moves" => []
    })
  end
end
