require 'tictactoe/web/responses/success'

module Tictactoe
  module Web
    module Endpoints
      class ShowMenu
        ROUTE = '/'
        TEMPLATE_PATH = 'lib/tictactoe/web/templates/menu.erb'

        def route
          ROUTE
        end

        def call(environment)
          body = Template.new.render
          Responses::Success.new(body)
        end

        private
        class Template
          def render
            ERB.new(File.new(TEMPLATE_PATH).read).result
          end
        end
      end
    end
  end
end
