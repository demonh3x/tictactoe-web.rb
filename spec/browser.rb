require 'ostruct'
require 'json'

module Server
  class Browser
    def initialize(app)
      self.app = app 
    end

    def get_response(environment_hash)
      parser.parse(app.call(environment_hash))
    end

    private
    attr_accessor :app
    
    def parser
      @parser ||= Parser.new
    end
  end

  private
  class Parser
    def parse(rake_response)
      response = OpenStruct.new
      response.code = get_code_from(rake_response)
      response.data = get_data_from(rake_response)
      response
    end

    private
    def get_code_from(rake_response)
      code_index = 0
      code = rake_response[code_index]
      Integer(code)
    end

    def get_data_from(rake_response)
      raw_body = get_raw_body_from(rake_response)
      JSON.parse(raw_body)
    end

    def get_raw_body_from(rake_response)
      body_index = 2
      body = rake_response[body_index].join('')
      body
    end
  end
end
