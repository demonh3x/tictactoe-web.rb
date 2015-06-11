module Tictactoe
  module Web
    class BoardPresenter
      def initialize(game)
        self.game = game
      end

      def cells
        game.marks
          .each_with_index
          .map { |mark, index| present_cell(mark, index) }
          .each_slice(game.board_size)
          .to_a
      end

      def result_message
        return nil unless game.is_finished?
        return "It is a draw!" if game.winner.nil?
        "Player #{winner.upcase} has won!"
      end

      def winner
        game.winner && game.winner.to_s
      end

      def restart_link
        "/game/start?board_size=#{game.board_size}&x_type=#{game.x_type}&o_type=#{game.o_type}"
      end

      def menu_link
        '/'
      end

      def should_redirect
        game.ready_to_tick?
      end

      def redirect_timeout
        1
      end

      def redirect_link
        '/game/tick'
      end

      private
      attr_accessor :game

      def present_cell(mark, index)
        text = present_cell_text(mark, index)
        link = present_cell_link(mark, index)

        [text, link]
      end

      def present_cell_text(mark, index)
        return '_' if mark.nil? && game.is_finished?
        return index.to_s if mark.nil?
        mark.to_s
      end

      def present_cell_link(mark, index)
        return nil if mark || game.is_finished? || should_redirect
        "/game/make_move?move=#{index}"
      end
    end
  end
end
