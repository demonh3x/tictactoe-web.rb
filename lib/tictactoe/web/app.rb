require 'tictactoe/web/show_board'
require 'tictactoe/web/start_game'
require 'tictactoe/web/make_move'

module Tictactoe
  module Web
    class App
      attr_accessor :app

      def initialize
        show_board = ShowBoard.new
        start_game = StartGame.new
        make_move = MakeMove.new

        self.app = Rack::Builder.new do
          map '/board' do
            run show_board
          end

          map '/game/start' do
            run start_game
          end

          map '/game/make_move' do
            run make_move
          end
        end
      end

      def call(environment)
        app.call(environment)
      end
    end
  end
end
