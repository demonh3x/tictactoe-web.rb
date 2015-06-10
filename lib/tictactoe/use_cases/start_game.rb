require 'tictactoe/game'
require 'tictactoe/players/factory'
require 'tictactoe/players/perfect_computer'

module Tictactoe
  module UseCases
    class StartGame
      def initialize(game_repository, game_class = Tictactoe::Game)
        self.game_repository = game_repository
        self.game_class = game_class
      end

      def call(board_size, x_type, o_type)
        moves = []

        game = game_class.new(players_factory(moves), board_size, x_type, o_type)

        game_repository[:game] = game
        game_repository[:moves] = moves
      end

      private
      attr_accessor :game_class, :game_repository

      def players_factory(moves)
        factory = Tictactoe::Players::Factory.new
        factory.register(:computer, ->(mark) { Tictactoe::Players::PerfectComputer.new(mark) })
        factory.register(:human, ->(mark) { HumanPlayer.new(mark, moves) })
        factory
      end

      class HumanPlayer
        attr_reader :mark

        def initialize(mark, moves)
          @mark = mark
          @moves = moves
        end

        def get_move(state)
          @moves.pop
        end

        def ready_to_move?
          !@moves.empty?
        end
      end
    end
  end
end
