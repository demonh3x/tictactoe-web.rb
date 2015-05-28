require 'json'

module Tictactoe
  module Web
    class ComposeStateIntoJson
      def call(state)
        to_data_structure(state).to_json
      end

      private
      def to_data_structure(state)
        {
          :marks => state.marks,
          :is_finished => state.is_finished?,
          :winner => state.winner,
          :available_moves => state.available_moves
        }
      end
    end
  end
end
