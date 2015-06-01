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

  it 'shows the first mark of a game' do
    html = get_html([
      :x,  nil, nil,
      nil, nil, nil,
      nil, nil, nil,
    ])
    expect(html.css('[data-board-cell="x"]').length).to eq 1
  end

  it 'shows the second mark of a game' do
    html = get_html([
      :x,  :o, nil,
      nil, nil, nil,
      nil, nil, nil,
    ])
    expect(html.css('[data-board-cell="o"]').length).to eq 1
  end

  it 'shows all the marks' do
    html = get_html([
      :o, :x, :o,
      :x, :o, :x,
      :x, :o, :x,
    ])
    expect(html.css('[data-board-cell="x"]').length).to eq 5
    expect(html.css('[data-board-cell="o"]').length).to eq 4
  end
end
