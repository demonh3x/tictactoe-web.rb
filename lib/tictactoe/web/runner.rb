require 'rack'
require 'tictactoe/web/app'

module Tictactoe
  module Web
    class Runner
      def run
        Rack::Handler::WEBrick.run App.new
      end
    end
  end
end
