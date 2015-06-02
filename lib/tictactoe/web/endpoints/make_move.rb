module Tictactoe
  module Web
    module Endpoints
      class MakeMove
        def initialize(make_move, show_board)
          self.make_move = make_move
          self.show_board = show_board
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
          response.redirect(show_board.route)
          response.finish
        end

        private
        attr_accessor :make_move, :show_board
      end
    end
  end
end
