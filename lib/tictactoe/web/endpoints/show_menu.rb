require 'tictactoe/web/responses/success'
require 'tictactoe/web/templates/erb_template'

module Tictactoe
  module Web
    module Endpoints
      class ShowMenu
        ROUTE = '/'

        def initialize
          self.template = Templates::ErbTemplate.new(:menu)
        end

        def route
          ROUTE
        end

        def call(environment)
          body = template.render
          Responses::Success.new(body)
        end

        private
        attr_accessor :template
      end
    end
  end
end
