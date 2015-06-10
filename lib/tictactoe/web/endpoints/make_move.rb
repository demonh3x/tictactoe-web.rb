require 'tictactoe/web/endpoints/make_move_arguments'
require 'tictactoe/web/responses/invalid_arguments'
require 'tictactoe/web/responses/redirect'

module Tictactoe
  module Web
    module Endpoints
      class MakeMove
        ROUTE = '/game/make_move'

        def initialize(make_move, show_board_route)
          self.make_move = make_move
          self.show_board_route = show_board_route
        end

        def route
          ROUTE
        end

        def call(environment)
          arguments = MakeMoveArguments.new(environment)
          return Responses::InvalidArguments.new unless arguments.valid?

          make_move.call(arguments.move)
          Responses::Redirect.new(show_board_route)
        end

        private
        attr_accessor :make_move, :show_board_route
      end
    end
  end
end
