require 'tictactoe/web/endpoints/start_game_arguments'
require 'tictactoe/web/responses/invalid_arguments'
require 'tictactoe/web/responses/redirect'

module Tictactoe
  module Web
    module Endpoints
      class StartGame
        ROUTE = '/game/start'

        def initialize(start_game, show_board_route)
          self.start_game = start_game
          self.show_board_route = show_board_route
        end

        def route
          ROUTE
        end

        def call(environment)
          arguments = StartGameArguments.new(environment)
          return Responses::InvalidArguments.new unless arguments.valid?

          start_game.call(arguments.board_size, arguments.x_type, arguments.o_type)
          Responses::Redirect.new(show_board_route)
        end

        private
        attr_accessor :start_game, :show_board_route
      end
    end
  end
end
