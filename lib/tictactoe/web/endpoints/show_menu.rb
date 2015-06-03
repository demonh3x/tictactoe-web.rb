module Tictactoe
  module Web
    module Endpoints
      class ShowMenu
        def route
          '/'
        end

        def call(environment)
          template_path = 'lib/tictactoe/web/templates/menu.erb'
          body = ERB.new(File.new(template_path).read).result(binding)

          response = Rack::Response.new(body)
          response.finish
        end
      end
    end
  end
end
