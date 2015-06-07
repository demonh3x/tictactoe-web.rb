require 'rack'

module Tictactoe
  module Web
    module Responses
      class InvalidArguments
        def self.new
          response = Rack::Response.new([], 400)
          response.write('At least one of the arguments is missing or invalid')
          response.finish
        end
      end
    end
  end
end
