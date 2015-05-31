module Tictactoe
  module Web
    class ShowBoard
      def call(environment)
        response = Rack::Response.new
        board = '<div data-board></div>'
        cell = '<div data-board-cell></div>'
        response.write(board + cell * 9)
        response.finish
      end
    end
  end
end
