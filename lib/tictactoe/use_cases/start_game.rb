require 'tictactoe/game'

module Tictactoe
  module UseCases
    class HumanPlayer
      attr_reader :mark

      def initialize(mark, moves)
        @mark = mark
        @moves = moves
      end

      def get_move(state)
        @moves.pop
      end
    end

    class StartGame
      def initialize(game_repository, game_class = Tictactoe::Game)
        self.game_repository = game_repository
        self.game_class = game_class
      end

      def call(board_size)
        game = game_class.new(board_size, :human, :human)
        moves = []
        human_factory = ->(mark) {HumanPlayer.new(mark, moves)}
        game.register_human_factory(human_factory)
        game_repository[:game] = game
        game_repository[:moves] = moves
      end

      private
      attr_accessor :game_class, :game_repository
    end
  end
end
