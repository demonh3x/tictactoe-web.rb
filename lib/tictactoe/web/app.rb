module Tictactoe
  module Web
    class App
      attr_accessor :app

      def initialize
        self.app = Rack::Builder.new do
          map '/board' do
            board = lambda do |environment|
              response = Rack::Response.new
              board = '<div data-board></div>'
              cell = '<div data-board-cell></div>'
              response.write(board + cell * 9)
              response.finish
            end
            run board
          end

          map '/game/start' do
            start_game = lambda do |environment|
              response = Rack::Response.new
              response.redirect('/board')
              response.finish
            end
            run start_game
          end

          map '/game/make_move' do
            make_move = lambda do |environment|
              response = Rack::Response.new
              response.redirect('/board')
              response.finish
            end
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
