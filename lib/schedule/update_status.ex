defmodule Timezoner.Schedule.UpdateStatus do
  use Timezoner.Schedule.Behaviour

  alias Nostrum.Api.Self
  alias Nostrum.Cache.GuildCache

  def task do
    guild_count = Enum.count(GuildCache.all())
    Self.update_status(:online, "for times in #{guild_count} servers!", 3)
  end
end
