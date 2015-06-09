require 'tictactoe/web/responses/success'

module Tictactoe
  module Web
    module Endpoints
      class ShowMenu
        ROUTE = '/'

        def initialize(menu_template)
          self.menu_template = menu_template
        end

        def route
          ROUTE
        end

        def call(environment)
          body = menu_template.render(nil)
          Responses::Success.new(body)
        end

        private
        attr_accessor :menu_template
      end
    end
  end
end
