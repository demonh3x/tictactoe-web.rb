require 'tictactoe/web/responses/success'
require 'tictactoe/web/board_presenter'

module Tictactoe
  module Web
    module Endpoints
      class ShowBoard
        ROUTE = '/game/board'
        TEMPLATE_PATH = 'lib/tictactoe/web/templates/board.erb'

        def initialize(show_board)
          self.show_board = show_board
          self.template = Template.new
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

        class Template
          def render(board)
            template = ERB.new(File.new(TEMPLATE_PATH).read)
            template.result(binding)
          end
        end
      end
    end
  end
end
