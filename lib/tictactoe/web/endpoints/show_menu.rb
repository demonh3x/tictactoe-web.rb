require 'tictactoe/web/responses/success'

module Tictactoe
  module Web
    module Endpoints
      class ShowMenu
        def route
          '/'
        end

        def call(environment)
          body = Template.new.render
          Responses::Success.new(body)
        end

        private
        class Template
          def render
            template_path = 'lib/tictactoe/web/templates/menu.erb'
            ERB.new(File.new(template_path).read).result
          end
        end
      end
    end
  end
end
