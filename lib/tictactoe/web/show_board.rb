module Tictactoe
  module Web
    class ShowBoard
      def initialize(game_gateway)
        self.game_gateway = game_gateway
      end

      def call()
        marks = game_gateway[:game].marks

        board = '<div data-board></div>'
        if marks[0] == nil
          cells = '<div data-board-cell></div>' * 9
        else
          cells = '<div data-board-cell="x"></div>'
          cells += '<div data-board-cell></div>' * 8
        end

        board + cells
      end

      private
      attr_accessor :game_gateway
    end
  end
end
