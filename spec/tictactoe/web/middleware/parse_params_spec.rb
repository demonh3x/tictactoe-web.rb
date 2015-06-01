require 'tictactoe/web/middleware/parse_arguments'

RSpec.describe Tictactoe::Web::Middleware::ParseArguments do
  let(:next_app) { spy() }
  let(:parser)   { described_class.new(next_app) }

  it 'parses the query string' do
    parser.call({'QUERY_STRING' => 'param=arg&array[]=0&array[]=1'})
    expect(next_app).to have_received(:call).with({
      'QUERY_STRING' => 'param=arg&array[]=0&array[]=1',
      'arguments' => {
        'param' => 'arg',
        'array' => ['0', '1']
      }
    })
  end
end
