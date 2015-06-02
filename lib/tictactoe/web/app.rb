require 'tictactoe/use_cases/show_board'
require 'tictactoe/use_cases/start_game'
require 'tictactoe/use_cases/make_move'

require 'tictactoe/web/endpoints/board'
require 'tictactoe/web/endpoints/start'
require 'tictactoe/web/endpoints/move'

module Tictactoe
  module Web
    class App
      def self.new
        game_gateway = {}

        board = Endpoints::Board.new(UseCases::ShowBoard.new(game_gateway))
        start = Endpoints::Start.new(UseCases::StartGame.new(game_gateway), board)
        move = Endpoints::Move.new(UseCases::MakeMove.new(game_gateway), board)

        create_web_app([board, start, move])
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
