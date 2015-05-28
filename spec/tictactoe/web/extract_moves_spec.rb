require 'tictactoe/web/extract_moves'

RSpec.describe Tictactoe::Web::ExtractMoves do
  let(:extract) { described_class.new }

  def expect_to_extract_from_path_the_moves(path, expected_moves)
    expect(extract.call(path)).to eq(expected_moves)
  end

  def expect_malformed(path)
    expect{extract.call(path)}.to raise_error
  end

  it 'extracts no moves' do
    expect_to_extract_from_path_the_moves('', [])
    expect_to_extract_from_path_the_moves('/', [])
  end

  it 'extracts one move' do
    expect_to_extract_from_path_the_moves('/0', [0])
    expect_to_extract_from_path_the_moves('/0/', [0])
  end

  it 'extracts several moves' do
    expect_to_extract_from_path_the_moves('/0/4/3/1', [0, 4, 3, 1])
    expect_to_extract_from_path_the_moves('/0/4/3/1/', [0, 4, 3, 1])
  end

  it 'malformed path with non-number sections' do
    expect_malformed('m')
    expect_malformed('/q')
  end
end
