require 'rack'

module Tictactoe
  module Web
    module Endpoints
      class StartGameArguments
        def self.parse_from_environment(environment)
          query_string = environment['QUERY_STRING']
          arguments = Rack::Utils.parse_nested_query(query_string)
          self.new(arguments)
        end

        def initialize(arguments_in_a_strings_hash)
          self.arguments = arguments_in_a_strings_hash
        end

        def valid?
          return false if any_argument_missing?
          valid_board_size? && valid_players?
        end

        def board_size
          Integer(arguments['board_size'])
        end

        def x_type
          arguments['x_type'].to_sym
        end

        def o_type
          arguments['o_type'].to_sym
        end

        private
        attr_accessor :arguments

        def valid_board_size?
          [3, 4].include?(board_size) rescue return false
        end

        def valid_players?
          [x_type, o_type].all? do |player|
            [:human, :computer].include? player
          end
        end

        def any_argument_missing?
          ['board_size', 'o_type', 'x_type'].any? do |argument|
            !arguments.has_key? argument
          end
        end
      end
    end
  end
end
