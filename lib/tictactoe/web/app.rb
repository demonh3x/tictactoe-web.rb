require 'tictactoe/use_cases/show_board'
require 'tictactoe/use_cases/start_game'
require 'tictactoe/use_cases/make_move'

require 'tictactoe/web/endpoints/show_board'
require 'tictactoe/web/endpoints/start_game'
require 'tictactoe/web/endpoints/make_move'

module Tictactoe
  module Web
    class App
      def self.new
        game_gateway = {}

        show_board = Endpoints::ShowBoard.new(UseCases::ShowBoard.new(game_gateway))
        start_game = Endpoints::StartGame.new(UseCases::StartGame.new(game_gateway), show_board)
        make_move = Endpoints::MakeMove.new(UseCases::MakeMove.new(game_gateway), show_board)

        create_web_app([show_board, start_game, make_move])
      end

      private
      def self.create_web_app(endpoints)
        Rack::Builder.new do
          endpoints.each do |endpoint|
            map endpoint.route do
              run endpoint
            end
          end
        end
      end
    end
  end
end
