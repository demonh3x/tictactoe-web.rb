class StateStub
  def initialize(marks, is_finished, winner)
    @marks = marks
    @is_finished = is_finished
    @winner = winner
  end

  def is_finished?
    @is_finished
  end

  attr_reader :marks, :winner
end
