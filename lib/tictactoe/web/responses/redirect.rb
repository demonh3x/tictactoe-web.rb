require 'rack'

module Tictactoe
  module Web
    module Responses
      class Redirect
        def self.new(location)
          response = Rack::Response.new
          response.redirect(location)
          response.finish
        end
      end
    end
  end
end
