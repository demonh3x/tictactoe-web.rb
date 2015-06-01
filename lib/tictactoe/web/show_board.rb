module Tictactoe
  module Web
    class ShowBoard
      def initialize(game_gateway)
        self.game_gateway = game_gateway
      end

      def call()
        marks = game_gateway[:game].marks

        board = '<div data-board></div>'
        cells = marks.map do |mark|
          if mark
            "<div data-board-cell=\"#{mark.to_s}\"></div>"
          else
            "<div data-board-cell></div>"
          end
        end

        board + cells.join
      end

      private
      attr_accessor :game_gateway
    end
  end
end
