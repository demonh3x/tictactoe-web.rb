module Tictactoe
  module Web
    module Endpoints
      class Start
        def initialize(start_game, next_endpoint)
          self.start_game = start_game
          self.next_endpoint = next_endpoint
        end

        def route
          '/game/start'
        end

        def call(environment)
          start_game.call()

          response = Rack::Response.new
          response.redirect(next_endpoint.route)
          response.finish
        end

        private
        attr_accessor :start_game, :next_endpoint
      end
    end
  end
end
