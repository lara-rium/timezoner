defmodule Timezoner.TzWorldUpdater do
  use GenServer

  alias TzWorld.Backend.DetsWithIndexCache

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    GenServer.cast(__MODULE__, :update)

    {:ok, nil}
  end

  @impl GenServer
  def handle_cast(:update, _) do
    Mix.Task.run("tz_world.update", ["--include-oceans"])
    DetsWithIndexCache.reload_timezone_data()

    1
    |> :timer.hours()
    |> :timer.apply_after(&GenServer.cast/2, [__MODULE__, :update])

    {:noreply, nil}
  end
end
