require 'state_stub'
require 'tictactoe/web/compose_state_into_json'

RSpec.describe Tictactoe::Web::ComposeStateIntoJson do
  let(:compose) { described_class.new }

  def expect_composed_state_to_json(state, expected_json_equivalent_hash)
    actual = JSON.parse(compose.call(state))
    expect(actual).to eq(expected_json_equivalent_hash)
  end

  it 'composes an initial state' do
    state = StateStub.new(
      [nil, nil, nil,
       nil, nil, nil,
       nil, nil, nil],
      false,
      nil,
      [0, 1, 2, 3, 4, 5, 6, 7, 8]
    )
    expect_composed_state_to_json(state, {
      "marks" => [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ],
      "is_finished" => false,
      "winner" => nil,
      "available_moves" => [0, 1, 2, 3, 4, 5, 6, 7, 8]
    })
  end

  it 'composes a finished state' do
    state = StateStub.new(
      [:x,  :o,  :o,
       nil, :x,  :o,
       nil, nil, :x],
      true,
      :x,
      []
    )
    expect_composed_state_to_json(state, {
      "marks" => [
        "x", "o", "o",
        nil, "x", "o",
        nil, nil, "x",
      ],
      "is_finished" => true,
      "winner" => "x",
      "available_moves" => []
    })
  end
end
