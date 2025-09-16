defmodule Timezoner.StatusUpdater do
  use GenServer

  alias Nostrum.Api.Self
  alias Nostrum.Cache.GuildCache

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    {:ok, nil}
  end

  def start_scheduling do
    GenServer.cast(__MODULE__, :update)
  end

  @impl GenServer
  def handle_cast(:update, _) do
    guild_count = Enum.count(GuildCache.all())
    Self.update_status(:online, "for times in #{guild_count} servers!", 3)

    1
    |> :timer.hours()
    |> :timer.apply_after(&GenServer.cast/2, [__MODULE__, :update])

    {:noreply, nil}
  end
end
