class StateStub
  def initialize(marks, is_finished, winner, available_moves)
    self.marks = marks
    self.is_finished = is_finished
    self.winner = winner
    self.available_moves = available_moves
  end

  def is_finished?
    is_finished
  end

  attr_accessor :marks, :is_finished, :winner, :available_moves
end
