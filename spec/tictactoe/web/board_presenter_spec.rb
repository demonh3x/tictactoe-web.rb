require 'tictactoe/web/board_presenter'
require 'game_stub'

RSpec.describe Tictactoe::Web::BoardPresenter do
  it 'shows the unocupied cells in a finished game' do
    game = GameStub.new(
      [:o, nil, nil,
       :o, nil, nil,
       :x, :x, :x],
       true,
       :x
    )
    presenter = described_class.new(game)
    expect(presenter.cells).to eq [
      [['o', nil], ['_', nil], ['_', nil]],
      [['o', nil], ['_', nil], ['_', nil]],
      [['x', nil], ['x', nil], ['x', nil]]
    ]
  end

  it 'contains the x winner message' do
    game = GameStub.new(
      [:o, nil, nil,
       :o, nil, nil,
       :x, :x, :x],
       true,
       :x
    )
    presenter = described_class.new(game)
    expect(presenter.result_message).to eq 'Player X has won!'
  end

  it 'contains the o winner message' do
    game = GameStub.new(
      [:o, nil, nil,
       :o, nil, :x,
       :o, :x,  :x],
       true,
       :o
    )
    presenter = described_class.new(game)
    expect(presenter.result_message).to eq 'Player O has won!'
  end

  it 'contains the draw message' do
    game = GameStub.new(
      [:x, :x, :o,
       :o, :o, :x,
       :x, :x, :o],
       true,
       nil
    )
    presenter = described_class.new(game)
    expect(presenter.result_message).to eq 'It is a draw!'
  end

  describe 'contains the restart link with the game configuration, for example:' do
    it 'board size 3 human vs human' do
      game = GameStub.new(
        [:x, :x, :o,
         :o, :o, :x,
         :x, :x, :o],
         true,
         nil,
         3,
         :human,
         :human
      )
      presenter = described_class.new(game)
      expect(presenter.restart_link).to eq '/game/start?board_size=3&x_type=human&o_type=human'
    end

    it 'board size 4 computer vs computer' do
      game = GameStub.new(
        [nil, nil, nil, nil,
         nil, nil, nil, nil,
         nil, nil, nil, nil,
         nil, nil, nil, nil],
         false,
         nil,
         4,
         :computer,
         :computer
      )
      presenter = described_class.new(game)
      expect(presenter.restart_link).to eq '/game/start?board_size=4&x_type=computer&o_type=computer'
    end
  end

  it 'contains the menu link' do
    game = GameStub.new(
      [:x, :x, :o,
       :o, :o, :x,
       :x, :x, :o],
       true,
       nil
    )
    presenter = described_class.new(game)
    expect(presenter.menu_link).to eq '/'
  end

  describe 'when the computer plays next' do
    let(:game) do
      ready_to_tick = true
      GameStub.new(
        [:x, nil, nil,
         :o, :o, :x,
         :x, :x, :o],
         false,
         nil,
         3,
         :human,
         :computer,
         ready_to_tick
      )
    end
    let(:presenter) { described_class.new(game) }

    it 'has to redirect' do
      expect(presenter.should_redirect).to eq true
    end

    it 'redirect automatically after 1 second' do
      expect(presenter.redirect_timeout).to eq 1
    end

    it 'redirects to tick' do
      expect(presenter.redirect_link).to eq '/game/tick'
    end

    it 'does not allow to select any moves' do
      expect(presenter.cells).to eq [
        [['x', nil], ['1', nil], ['2', nil]],
        [['o', nil], ['o', nil], ['x', nil]],
        [['x', nil], ['x', nil], ['o', nil]]
      ]
    end
  end

  describe 'when the human plays next' do
    let(:game) do
      ready_to_tick = false
      GameStub.new(
        [:x, nil, nil,
         :o, :o, :x,
         :x, :x, :o],
         false,
         nil,
         3,
         :human,
         :human,
         ready_to_tick
      )
    end
    let(:presenter) { described_class.new(game) }

    it 'does not redirect' do
      expect(presenter.should_redirect).to eq false
    end

    it 'contains the cell links to make moves' do
      expect(presenter.cells).to eq [
        [['x', nil], ['1', '/game/make_move?move=1'], ['2', '/game/make_move?move=2']],
        [['o', nil], ['o', nil], ['x', nil]],
        [['x', nil], ['x', nil], ['o', nil]]
      ]
    end
  end
end
