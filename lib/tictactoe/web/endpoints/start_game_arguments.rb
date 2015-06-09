module Tictactoe
  module Web
    module Endpoints
      class StartGameArguments
        def initialize(environment)
          self.environment = environment
        end

        def valid?
          [3, 4].include? board_size rescue false
        end

        def board_size
          Integer(query['board_size'])
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
