require 'tictactoe/web/responses/redirect'

module Tictactoe
  module Web
    module Endpoints
      class MakeMove
        ROUTE = '/game/make_move'

        def initialize(make_move, show_board)
          self.make_move = make_move
          self.show_board = show_board
        end

        def route
          ROUTE
        end

        def call(environment)
          arguments = Arguments.new(environment)
          return Responses::InvalidArguments.new unless arguments.are_valid?

          make_move.call(arguments.move)
          Responses::Redirect.new(show_board.route)
        end

        private
        attr_accessor :make_move, :show_board

        class Arguments
          def initialize(environment)
            self.environment = environment
          end

          def are_valid?
            move rescue false
          end

          def move
            Integer(query['move'])
          end

          private
          attr_accessor :environment

          def query
            query_string = environment['QUERY_STRING']
            Rack::Utils.parse_nested_query(query_string)
          end
        end
      end
    end
  end
end
