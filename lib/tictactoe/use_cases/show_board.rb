module Tictactoe
  module UseCases
    class ShowBoard
      def initialize(game_repository)
        self.game_repository = game_repository
      end

      def call
        game.state
      end

      private
      attr_accessor :game_repository

      def game
        game_repository[:game]
      end
    end
  end
end
