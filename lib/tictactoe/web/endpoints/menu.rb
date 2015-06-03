module Tictactoe
  module Web
    module Endpoints
      class Menu
        def route
          '/'
        end

        def call(environment)
          template_path = 'lib/tictactoe/web/templates/menu.erb'
          body = File.new(template_path).read
          Rack::Response.new(body)
        end
      end
    end
  end
end
