module Tictactoe
  module Web
    class Router
      def initialize(routes, default_handler = lambda {|env| raise 'No default handler has been defined!'})
        self.routes = routes
        self.default_handler = default_handler
      end

      def call(environment)
        routes.each do |selector, handler|
          return handler.call(environment) if selector.call(environment)
        end
        default_handler.call(environment)
      end

      private
      attr_accessor :routes, :default_handler
    end
  end
end
