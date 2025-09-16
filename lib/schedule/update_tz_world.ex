defmodule Timezoner.Schedule.UpdateTzWorld do
  use Timezoner.Schedule.Behaviour

  alias TzWorld.Backend.DetsWithIndexCache

  def task do
    Mix.Task.run("tz_world.update", ["--include-oceans"])
    DetsWithIndexCache.reload_timezone_data()
  end
end
