require 'tictactoe/web/responses/success'
require 'tictactoe/web/board_presenter'

module Tictactoe
  module Web
    module Endpoints
      class ShowBoard
        ROUTE = '/game/board'

        def initialize(show_board, board_template)
          self.show_board = show_board
          self.board_template = board_template
        end

        def route
          ROUTE
        end

        def call(environment)
          board = show_board.call

          presenter = BoardPresenter.new(board)
          body = board_template.render(presenter)
          response = Responses::Success.new(body)

          response
        end

        private
        attr_accessor :show_board, :board_template
      end
    end
  end
end
