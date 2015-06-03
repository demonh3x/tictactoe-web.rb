module Tictactoe
  module Web
    module Endpoints
      class StartGame
        def initialize(start_game, show_board)
          self.start_game = start_game
          self.show_board = show_board
        end

        def route
          '/game/start'
        end

        def call(environment)
          query = environment['QUERY_STRING']
          arguments = Rack::Utils.parse_nested_query(query)
          board_size = Integer(arguments['board_size'])

          start_game.call(board_size)

          response = Rack::Response.new
          response.redirect(show_board.route)
          response.finish
        end

        private
        attr_accessor :start_game, :show_board
      end
    end
  end
end
