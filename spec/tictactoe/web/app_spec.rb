require 'tictactoe/web/app'
require 'browser'
require 'environment'

RSpec.describe Tictactoe::Web::App do
  let(:app)      { described_class.new }
  let(:browser)  { Server::Browser.new(app) }
  let(:env)      { Server::Environment.new }
  let(:response) { browser.get_response(env.hash) }
  
  it 'creates a new game' do
    env.set_uri('/new')
    expect(response.code).to eq 200
    expect(response.data).to eq({
      "a" => [1, 2, 3]
    })
  end
end
