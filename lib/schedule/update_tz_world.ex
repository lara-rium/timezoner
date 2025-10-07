defmodule Timezoner.Schedule.UpdateTzWorld do
  use Larabot.Schedule

  alias Mix.Tasks.TzWorld.Update
  alias TzWorld.Backend.DetsWithIndexCache

  def interval, do: :timer.hours(1)

  def task do
    Update.update(true, false, false)
    DetsWithIndexCache.reload_timezone_data()
  end
end
