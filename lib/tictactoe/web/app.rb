module Tictactoe
  module Web
    class App
      attr_accessor :app

      def initialize
        self.app = Rack::Builder.new do
          map "/board" do
            board = lambda do |environment|
              res = Rack::Response.new
              res.finish
            end
            run board
          end
          map "/game/start" do
            start_game = lambda do |environment|
              res = Rack::Response.new
              res.redirect('/board')
              res.finish
            end
            run start_game
          end
        end
      end

      def call(environment)
        app.call(environment)
      end
    end
  end
end
