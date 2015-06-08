require 'tictactoe/web/board_presenter'
require 'state_stub'

RSpec.describe Tictactoe::Web::BoardPresenter do
  def board(state)
    described_class.new(state)
  end

  it 'contains the cell links to make moves' do
    state = StateStub.new(
      [:x, nil, nil,
       :o, :o, :x,
       :x, :x, :o],
       false,
       nil
    )
    board = board(state)
    expect(board.cells).to eq [
      [['x', nil], ['1', '/game/make_move?move=1'], ['2', '/game/make_move?move=2']],
      [['o', nil], ['o', nil], ['x', nil]],
      [['x', nil], ['x', nil], ['o', nil]]
    ]
  end

  it 'shows the unocupied cells in a finished game' do
    state = StateStub.new(
      [:o, nil, nil,
       :o, nil, nil,
       :x, :x, :x],
       true,
       :x
    )
    board = board(state)
    expect(board.cells).to eq [
      [['o', nil], ['_', nil], ['_', nil]],
      [['o', nil], ['_', nil], ['_', nil]],
      [['x', nil], ['x', nil], ['x', nil]]
    ]
  end

  it 'contains the x winner message' do
    state = StateStub.new(
      [:o, nil, nil,
       :o, nil, nil,
       :x, :x, :x],
       true,
       :x
    )
    board = board(state)
    expect(board.result_message).to eq "Player X has won!"
  end

  it 'contains the o winner message' do
    state = StateStub.new(
      [:o, nil, nil,
       :o, nil, :x,
       :o, :x,  :x],
       true,
       :o
    )
    board = board(state)
    expect(board.result_message).to eq "Player O has won!"
  end

  it 'contains the draw message' do
    state = StateStub.new(
      [:x, :x, :o,
       :o, :o, :x,
       :x, :x, :o],
       true,
       nil
    )
    board = board(state)
    expect(board.result_message).to eq "It is a draw!"
  end

  it 'contains the restart link' do
    state = StateStub.new(
      [:x, :x, :o,
       :o, :o, :x,
       :x, :x, :o],
       true,
       nil
    )
    board = board(state)
    expect(board.restart_link).to eq "/game/start?board_size=3"
  end

  it 'contains the menu link' do
    state = StateStub.new(
      [:x, :x, :o,
       :o, :o, :x,
       :x, :x, :o],
       true,
       nil
    )
    board = board(state)
    expect(board.menu_link).to eq "/"
  end
end
