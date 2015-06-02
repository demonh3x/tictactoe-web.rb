module Tictactoe
  module Web
    module Endpoints
      class Move
        def initialize(make_move, next_endpoint)
          self.make_move = make_move
          self.next_endpoint = next_endpoint
        end

        def route
          '/game/make_move'
        end

        def call(environment)
          query = environment['QUERY_STRING']
          arguments = Rack::Utils.parse_nested_query(query)
          move = Integer(arguments['move'])

          make_move.call(move)

          response = Rack::Response.new
          response.redirect(next_endpoint.route)
          response.finish
        end

        private
        attr_accessor :make_move, :next_endpoint
      end
    end
  end
end
