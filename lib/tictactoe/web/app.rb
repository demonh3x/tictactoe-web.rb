require 'tictactoe/web/show_board'
require 'tictactoe/web/start_game'
require 'tictactoe/web/make_move'

module Tictactoe
  module Web
    class App
      def self.new
        game_gateway = {}

        show_board = ShowBoard.new(game_gateway)
        start_game = StartGame.new(game_gateway)
        make_move = MakeMove.new(game_gateway)

        create_web_app(show_board, start_game, make_move)
      end

      private
      def self.create_web_app(show_board, start_game, make_move)
        Rack::Builder.new do
          map '/game/board' do
            run ->(environment) do
              board = show_board.call()
              App.respond(board)
            end
          end

          map '/game/start' do
            run ->(environment) do
              start_game.call()
              App.redirect_to('/game/board')
            end
          end

          map '/game/make_move' do
            run ->(environment) do
              query = environment['QUERY_STRING']
              arguments = Rack::Utils.parse_nested_query(query)
              move = Integer(arguments['move'])
              make_move.call(move)
              App.redirect_to('/game/board')
            end
          end
        end
      end

      def self.redirect_to(route)
        response = Rack::Response.new
        response.redirect(route)
        response.finish
      end

      def self.respond(body)
        response = Rack::Response.new
        response.write(body)
        response.finish
      end
    end
  end
end
