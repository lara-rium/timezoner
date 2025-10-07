defmodule Timezoner.Consumer.Ready do
  @behaviour Larabot.Consumer

  alias Timezoner.Schedule

  def handle(_) do
    Timezoner.Interactions.register()

    Schedule.UpdateStatus.start()
    Schedule.UpdateTzWorld.start()
  end
end
