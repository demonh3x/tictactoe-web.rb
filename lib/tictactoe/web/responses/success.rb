require 'rack'

module Tictactoe
  module Web
    module Responses
      class Success
        def self.new(body)
          response = Rack::Response.new
          response.write(body)
          response.finish
        end
      end
    end
  end
end
