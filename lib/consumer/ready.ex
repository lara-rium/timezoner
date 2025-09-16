defmodule Timezoner.Consumer.Ready do
  @behaviour Timezoner.Consumer.Behaviour

  alias Timezoner.Schedule

  def handle(_) do
    Timezoner.Interactions.register()

    Schedule.UpdateStatus.start()
    Schedule.UpdateTzWorld.start()
  end
end
