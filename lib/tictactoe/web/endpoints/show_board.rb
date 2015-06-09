require 'tictactoe/web/responses/success'
require 'tictactoe/web/board_presenter'
require 'tictactoe/web/templates/erb_template'

module Tictactoe
  module Web
    module Endpoints
      class ShowBoard
        ROUTE = '/game/board'

        def initialize(show_board)
          self.show_board = show_board
          self.template = Templates::ErbTemplate.new(:board)
        end

        def route
          ROUTE
        end

        def call(environment)
          board = show_board.call

          presenter = BoardPresenter.new(board)
          body = template.render(presenter)
          response = Responses::Success.new(body)

          response
        end

        private
        attr_accessor :show_board, :template
      end
    end
  end
end
