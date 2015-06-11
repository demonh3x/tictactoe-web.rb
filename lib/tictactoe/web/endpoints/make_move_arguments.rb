module Tictactoe
  module Web
    module Endpoints
      class MakeMoveArguments
        def initialize(environment)
          self.environment = environment
        end

        def valid?
          move rescue false
        end

        def move
          Integer(query['move'])
        end

        private
        attr_accessor :environment

        def query
          query_string = environment['QUERY_STRING']
          Rack::Utils.parse_nested_query(query_string)
        end
      end
    end
  end
end
