require 'rack/utils'

module Tictactoe
  module Web
    module Middleware
      class ParseArguments
        def initialize(next_app)
          self.next_app = next_app
        end

        def call(environment)
          environment['arguments'] = Rack::Utils.parse_nested_query(environment['QUERY_STRING'])
          next_app.call(environment)
        end

        private
        attr_accessor :next_app
      end
    end
  end
end
