RSpec.describe Tictactoe::Web::ShowBoard do
  class GameStub
    def initialize(marks)
      @marks = marks
    end

    attr_reader :marks
  end

  def get_html(marks)
    game = GameStub.new(marks)
    game_gateway = {:game => game}
    show_board = described_class.new(game_gateway)
    Nokogiri::HTML(show_board.call())
  end

  describe 'given an empty board' do
    let(:html) do
      get_html([
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ])
    end

    it 'contains a board' do
      expect(html.css('[data-board]').length).to eq 1
    end

    it 'contains the board cells' do
      expect(html.css('[data-board-cell]').length).to eq 9
    end
  end

  describe 'given a board with the first move' do
    let(:html) do
      get_html([
        :x,  nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ])
    end

    it 'contains the move' do
      expect(html.css('[data-board-cell="x"]').length).to eq 1
    end
  end
end
