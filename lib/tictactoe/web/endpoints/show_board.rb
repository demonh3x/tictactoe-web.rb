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
          template_path = 'lib/tictactoe/web/templates/board.erb'
          template = ERB.new(File.new(template_path).read)

          board = show_board.call(template)

          Rack::Response.new(board).finish
        end

        private
        attr_accessor :show_board
      end
    end
  end
end
