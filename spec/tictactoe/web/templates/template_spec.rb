require 'spec_helper'
require 'fakefs/spec_helpers'
require 'tictactoe/web/templates/template'

RSpec.describe Tictactoe::Web::Templates::Template do
  include FakeFS::SpecHelpers

  class PresenterStub
    def value
      'presented value'
    end
  end

  let(:template_path) { described_class.lookup_path + '/template_name.erb' }

  before(:each) do
    FileUtils.mkpath(described_class.lookup_path)
    File.open(template_path, 'w+') do |file|
      file.write('template with <%= presenter.value %>')
    end
  end

  it 'displays the presenter value in the template' do
    template = described_class.new(:template_name)
    presenter = PresenterStub.new
    expect(template.render(presenter)).to eq('template with presented value')
  end
end
