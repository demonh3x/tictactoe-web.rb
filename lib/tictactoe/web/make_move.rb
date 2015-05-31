module Tictactoe
  module Web
    class MakeMove
      def call(environment)
        response = Rack::Response.new
        response.redirect('/board')
        response.finish
      end
    end
  end
end
