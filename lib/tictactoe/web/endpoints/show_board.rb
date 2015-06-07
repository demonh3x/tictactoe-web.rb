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

          template_path = 'lib/tictactoe/web/templates/board.erb'
          template = ERB.new(File.new(template_path).read)
          body = template.result(binding)
          Responses::Success.new(body)
        end

        private
        attr_accessor :show_board
      end
    end
  end
end
