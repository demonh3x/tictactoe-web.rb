require 'tictactoe/web/responses/redirect'
require 'tictactoe/web/responses/invalid_arguments'

module Tictactoe
  module Web
    module Endpoints
      class StartGame
        def initialize(start_game, show_board)
          self.start_game = start_game
          self.show_board = show_board
        end

        def route
          '/game/start'
        end

        def call(environment)
          arguments = Arguments.new(environment)
          return Responses::InvalidArguments.new unless arguments.valid?

          start_game.call(arguments.board_size)
          Responses::Redirect.new(show_board.route)
        end

        private
        attr_accessor :start_game, :show_board

        class Arguments
          def initialize(environment)
            self.environment = environment
          end

          def valid?
            [3, 4].include? board_size rescue false
          end

          def board_size
            Integer(query['board_size'])
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
