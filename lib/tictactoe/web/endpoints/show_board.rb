require 'tictactoe/web/responses/success'

module Tictactoe
  module Web
    module Endpoints
      class ShowBoard
        def initialize(show_board)
          self.show_board = show_board
        end

        def route
          '/game/board'
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
            template_path = 'lib/tictactoe/web/templates/board.erb'
            template = ERB.new(File.new(template_path).read)
            template.result(binding)
          end
        end
      end
    end
  end
end
