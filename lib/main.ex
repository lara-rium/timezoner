defmodule Timezoner.Main do
  use Application

  def start(_, _) do
    HTTPoison.start()

    Supervisor.start_link(
      [
        Geocoder.Supervisor,
        Timezoner.Consumer,
        Timezoner.Repo,
        Timezoner.StatusUpdater,
        Timezoner.TzWorldUpdater,
        TzWorld.Backend.DetsWithIndexCache
      ],
      strategy: :one_for_one,
      name: __MODULE__
    )
  end
end
