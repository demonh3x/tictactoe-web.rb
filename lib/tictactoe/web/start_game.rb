require 'tictactoe/game'

module Tictactoe
  module Web
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
      def initialize(game_gateway, game_class = Tictactoe::Game)
        self.game_gateway = game_gateway
        self.game_class = game_class
      end

      def call()
        game = game_class.new(3, :human, :human)
        moves = []
        human_factory = ->(mark) {HumanPlayer.new(mark, moves)}
        game.register_human_factory(human_factory)
        game_gateway[:game] = game
        game_gateway[:moves] = moves
      end

      private
      attr_accessor :game_class, :game_gateway
    end
  end
end
