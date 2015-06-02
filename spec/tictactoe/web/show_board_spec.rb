RSpec.describe Tictactoe::Web::ShowBoard do
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

  let(:marks)        { :marks }
  let(:game)         { GameStub.new(marks) }
  let(:game_gateway) { {:game => game} }
  let(:show_board)   { described_class.new(game_gateway) }

  it 'lets the template access the game marks' do
    template = TemplateSpy.new

    show_board.call(template)

    binding = template.received_binding
    expect(binding.local_variable_get(:marks)).to equal game.marks
  end

  it 'returns the template result' do
    template = TemplateStub.new(:result)

    expect(show_board.call(template)).to eq :result
  end
end
