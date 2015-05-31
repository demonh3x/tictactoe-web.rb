require 'tictactoe/web/show_board'
require 'tictactoe/web/start_game'
require 'tictactoe/web/make_move'

module Tictactoe
  module Web
    class App
      def self.new
        show_board = ShowBoard.new
        start_game = StartGame.new
        make_move = MakeMove.new

        Rack::Builder.new do
          map '/game/board' do
            run show_board
          end

          map '/game/start' do
            run ->(environment) do
              start_game.call(environment)
              App.redirect_to('/game/board')
            end
          end

          map '/game/make_move' do
            run ->(environment) do
              make_move.call(environment)
              App.redirect_to('/game/board')
            end
          end
        end
      end

      private
      def self.redirect_to(route)
        response = Rack::Response.new
        response.redirect(route)
        response.finish
      end
    end
  end
end
