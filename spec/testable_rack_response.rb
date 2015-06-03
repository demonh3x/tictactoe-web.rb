class TestableRackResponse
  def initialize(rack_response)
    self.rack_response = rack_response
  end

  def status
    rack_response[0]
  end

  def headers
    rack_response[1]
  end

  def body
    body = ''
    rack_response[2].each do |partial_body|
      body += partial_body
    end
    body
  end

  private
  attr_accessor :rack_response
end
