defmodule Timezoner.Application do
  use Application

  def start(_, _) do
    Supervisor.start_link(
      [
        Geocoder.Supervisor,
        Timezoner.Repo,
        TzWorld.Backend.DetsWithIndexCache,
        Timezoner.Schedule.UpdateTzWorld,
        Timezoner.Schedule.UpdateStatus,
        Timezoner.Consumer
      ],
      strategy: :one_for_one,
      name: __MODULE__
    )
  end
end
