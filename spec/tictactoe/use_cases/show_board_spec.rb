require 'spec_helper'
require 'tictactoe/use_cases/show_board'

RSpec.describe Tictactoe::UseCases::ShowBoard do
  class GameStub
    def initialize(state)
      @state = state
    end

    attr_reader :state
  end

  class TemplateSpy
    def result(binding)
      @received_binding = binding
    end

    attr_reader :received_binding
  end

  class TemplateStub
    def initialize(result)
      @result = result
    end

    def result(binding)
      @result
    end
  end

  let(:game)            { GameStub.new(:state) }
  let(:game_repository) { {:game => game} }
  let(:show_board)      { described_class.new(game_repository) }

  it 'returns the template result' do
    template = TemplateStub.new(:result)
    expect(show_board.call(template)).to eq :result
  end

  it 'lets the template access the game state' do
    template = TemplateSpy.new
    show_board.call(template)
    expect(state_sent_to(template)).to equal game.state
  end

  def state_sent_to(template)
    binding = template.received_binding
    binding.eval('game_state')
  end
end
