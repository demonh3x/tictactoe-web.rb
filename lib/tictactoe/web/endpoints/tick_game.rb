require 'tictactoe/web/responses/redirect'

module Tictactoe
  module Web
    module Endpoints
      class TickGame
        ROUTE = '/game/tick'

        def initialize(tick_game, show_board_route)
          self.tick_game = tick_game
          self.show_board_route = show_board_route
        end

        def route
          ROUTE
        end

        def call(environment)
          tick_game.call
          Responses::Redirect.new(show_board_route)
        end

        private
        attr_accessor :tick_game, :show_board_route
      end
    end
  end
end
