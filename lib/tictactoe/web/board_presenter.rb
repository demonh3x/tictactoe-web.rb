module Tictactoe
  module Web
    class BoardPresenter
      def initialize(state)
        self.state = state
      end

      def cells
        marks
          .each_with_index
          .map { |mark, index| present_cell(mark, index) }
          .each_slice(side_size)
          .to_a
      end

      def result_message
        return nil unless state.is_finished?
        return "It is a draw!" if winner.nil?
        "Player #{winner.upcase} has won!"
      end

      def is_finished?
        state.is_finished?
      end

      def winner
        state.winner && state.winner.to_s
      end

      def restart_link
        "/game/start?board_size=#{side_size}"
      end

      def menu_link
        '/'
      end

      private
      attr_accessor :state

      def side_size
        Math.sqrt(marks.length).to_i
      end

      def marks
        state.marks
      end

      def present_cell(mark, index)
        text = present_cell_text(mark, index)
        link = present_cell_link(mark, index)

        [text, link]
      end

      def present_cell_text(mark, index)
        return '_' if mark.nil? && state.is_finished?
        return index.to_s if mark.nil?
        mark.to_s
      end

      def present_cell_link(mark, index)
        return nil if mark || state.is_finished?
        "/game/make_move?move=#{index}"
      end
    end
  end
end
