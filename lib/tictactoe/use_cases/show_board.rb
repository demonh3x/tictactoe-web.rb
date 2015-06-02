module Tictactoe
  module UseCases
    class ShowBoard
      def initialize(game_gateway)
        self.game_gateway = game_gateway
      end

      def call(board_template)
        marks = game_gateway[:game].marks
        board_template.result(binding)
      end

      private
      attr_accessor :game_gateway
    end
  end
end
