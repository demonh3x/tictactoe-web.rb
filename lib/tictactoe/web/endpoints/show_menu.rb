require 'tictactoe/web/responses/success'

module Tictactoe
  module Web
    module Endpoints
      class ShowMenu
        def route
          '/'
        end

        def call(environment)
          template_path = 'lib/tictactoe/web/templates/menu.erb'
          body = ERB.new(File.new(template_path).read).result

          Responses::Success.new(body)
        end
      end
    end
  end
end
