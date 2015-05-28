module Server
  class Environment
    def set_uri(uri)
      hash['REQUEST_PATH'] = uri
      self
    end

    def hash
      @hash ||= {}
    end
  end
end
