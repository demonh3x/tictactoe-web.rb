module Tictactoe
  module Web
    class ShowBoard
      def initialize(game_gateway)
        self.game_gateway = game_gateway
      end

      def call()
        marks = game_gateway[:game].marks
        template = %{
          <div data-board>
            <% marks.each_with_index do |mark, index| %>
            <div data-board-cell="<%= mark.to_s %>">
              <% if mark %>
                <%= mark.to_s %>
              <% else %>
              <a href="/game/make_move?move=<%= index.to_s %>">
                <%= index.to_s %>
              </a>
              <% end %>
            </div>
            <% end %>
          </div>
        }
        ERB.new(template).result(binding)
      end

      private
      attr_accessor :game_gateway
    end
  end
end
