class GameStub
  def initialize(marks, is_finished, winner, board_size = 3, x_type = :human, o_type = :human, ready_to_tick = false)
    @marks = marks
    @is_finished = is_finished
    @winner = winner
    @board_size = board_size
    @x_type = x_type
    @o_type = o_type
    @ready_to_tick = ready_to_tick
  end

  def is_finished?
    @is_finished
  end

  def ready_to_tick?
    @ready_to_tick
  end

  attr_reader :marks, :winner, :board_size, :x_type, :o_type
end
