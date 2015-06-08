require 'tictactoe/web/responses/success'

module Tictactoe
  module Web
    module Endpoints
      class ShowBoard
        ROUTE = '/game/board'
        TEMPLATE_PATH = 'lib/tictactoe/web/templates/board.erb'

        def initialize(show_board)
          self.show_board = show_board
        end

        def route
          ROUTE
        end

        def call(environment)
          board = show_board.call

          body = Template.new.render(board)
          Responses::Success.new(body)
        end

        private
        attr_accessor :show_board

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
