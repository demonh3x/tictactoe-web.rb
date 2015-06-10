module Tictactoe
  module UseCases
    class ShowBoard
      def initialize(game_repository)
        self.game_repository = game_repository
      end

      def call
        game_repository[:game]
      end

      private
      attr_accessor :game_repository
    end
  end
end
