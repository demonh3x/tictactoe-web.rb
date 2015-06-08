require 'rack'

module Tictactoe
  module Web
    module Responses
      class InvalidArguments
        MESSAGE = 'At least one of the arguments is missing or invalid'

        def self.new
          response = Rack::Response.new([], 400)
          response.write(MESSAGE)
          response.finish
        end
      end
    end
  end
end
