module Tictactoe
  module Web
    class ExtractMoves
      def call(path)
        get_numbers(path)
      end

      private
      def get_numbers(path)
        remove_initial_slash(path)
          .split('/')
          .map{|move_string| Integer(move_string)}
      end

      def remove_initial_slash(path)
        path.sub(/^\//, '')
      end
    end
  end
end
