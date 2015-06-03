module Tictactoe
  module UseCases
    class MakeMove
      def initialize(game_repository)
        self.game_repository = game_repository
      end

      def call(move)
        moves = game_repository[:moves]
        game = game_repository[:game]

        moves << move
        game.tick
      end

      private
      attr_accessor :game_repository
    end
  end
end
