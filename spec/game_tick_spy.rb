class GameTickSpy
  def tick
    @has_tick_been_called = true
  end

  def has_been_ticked?
    @has_tick_been_called
  end
end
