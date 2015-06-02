module Tictactoe
  module UseCases
    class MakeMove
      def initialize(game_gateway)
        self.game_gateway = game_gateway
      end

      def call(move)
        moves = game_gateway[:moves]
        game = game_gateway[:game]

        moves << move
        game.tick
      end

      private
      attr_accessor :game_gateway
    end
  end
end
