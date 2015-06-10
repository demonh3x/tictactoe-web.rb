require 'spec_helper'
require 'rack/test'
require 'nokogiri'
require 'tictactoe/web/endpoints/show_menu'
require 'tictactoe/web/templates/erb_template'

RSpec.describe Tictactoe::Web::Endpoints::ShowMenu do
  include Rack::Test::Methods

  let(:template)     { Tictactoe::Web::Templates::ErbTemplate.new(:menu) }
  let(:app)          { described_class.new(template) }
  let(:environment)  { {} }
  let(:response)     { get '/'; last_response }
  let(:html)         { Nokogiri::HTML(response.body) }

  it 'is mapped to the root route' do
    expect(app.route).to eq '/'
  end

  it 'responds successfully' do
    expect(response.status).to eq 200
  end

  describe 'contains the options' do
    let(:form) { html.css('form').first }

    it 'board size 3' do
      expect(form.css('input[value="3"][name="board_size"]').length).to eq 1
    end

    it 'board size 4' do
      expect(form.css('input[value="4"][name="board_size"]').length).to eq 1
    end

    it 'x human' do
      expect(form.css('input[value="human"][name="x_type"]').length).to eq 1
    end

    it 'x computer' do
      expect(form.css('input[value="computer"][name="x_type"]').length).to eq 1
    end

    it 'o human' do
      expect(form.css('input[value="human"][name="o_type"]').length).to eq 1
    end

    it 'o computer' do
      expect(form.css('input[value="computer"][name="o_type"]').length).to eq 1
    end
  end
end
