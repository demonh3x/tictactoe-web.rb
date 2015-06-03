module Tictactoe
  module UseCases
    class ShowBoard
      def initialize(game_repository)
        self.game_repository = game_repository
      end

      def call(board_template)
        marks = game_repository[:game].marks
        board_template.result(binding)
      end

      private
      attr_accessor :game_repository
    end
  end
end
