require 'spec_helper'
require 'tictactoe/use_cases/show_board'

RSpec.describe Tictactoe::UseCases::ShowBoard do
  class GameStub
    def initialize(marks)
      @marks = marks
    end

    attr_reader :marks
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

  let(:marks)           { :marks }
  let(:game)            { GameStub.new(marks) }
  let(:game_repository) { {:game => game} }
  let(:show_board)      { described_class.new(game_repository) }

  it 'lets the template access the game marks' do
    template = TemplateSpy.new

    show_board.call(template)

    expect(marks_sent_to(template)).to equal game.marks
  end

  def marks_sent_to(template)
    binding = template.received_binding
    binding.eval('marks')
  end

  it 'returns the template result' do
    template = TemplateStub.new(:result)

    expect(show_board.call(template)).to eq :result
  end
end
