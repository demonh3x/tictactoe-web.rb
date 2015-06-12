module Tictactoe
  module Web
    module Templates
      class Template
        def self.lookup_path
          File.dirname(__FILE__)
        end

        def initialize(name)
          self.file_path = File.expand_path(self.class.lookup_path + "/#{name.to_s}.erb")
        end

        def render(presenter)
          ERB.new(File.new(file_path).read).result(binding)
        end

        private
        attr_accessor :file_path
      end
    end
  end
end
