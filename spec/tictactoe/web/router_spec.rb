require 'tictactoe/web/router'

RSpec.describe Tictactoe::Web::Router do
  class HandlerSpy
    attr_accessor :received_argument

    def initialize(return_value)
      @return_value = return_value
    end

    def call(argument)
      @received_argument = argument
      @return_value
    end
  end

  let(:environment) {{:path => '/route/remaining_path'}}

  it 'routes to the handler assigned with the first matching selector' do
    non_matching_selector = lambda {|env| false}
    first_matching_selector = lambda {|env| /^\/route/ =~ env[:path]}
    first_handler = HandlerSpy.new(:first_handler_result)
    second_matching_selector = lambda {|env| true}

    router = described_class.new({
      non_matching_selector => :ignored_handler,
      first_matching_selector => first_handler,
      second_matching_selector => :ignored_handler
    })

    result = router.call(environment)

    expect(result).to eq(:first_handler_result)
    expect(first_handler.received_argument).to eq(environment)
  end

  it 'routes to the default handler when no selector matches' do
    default_handler = HandlerSpy.new(:default_result)
    router = described_class.new({}, default_handler)

    result = router.call(environment)

    expect(result).to eq(:default_result)
    expect(default_handler.received_argument).to eq(environment)
  end
    
  it 'raises error when there is no matching selector' do
    router = described_class.new({})
    expect{router.call(environment)}
      .to raise_error('No default handler has been defined!')
  end
end
