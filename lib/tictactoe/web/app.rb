module Tictactoe
  module Web
    class App
      def call(environment)
        [200, {}, ['{"a": [1, 2, 3]}']]
      end
    end
  end
end
