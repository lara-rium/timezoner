import Config

config :timezoner,
  ecto_repos: [Timezoner.Repo],
  guild_id: nil

config :timezoner, Timezoner.Repo,
  database: "timezoner_repo",
  username: "lara",
  hostname: "localhost"

config :nostrum,
  ffmpeg: nil,
  log_full_events: Mix.env() != :prod,
  log_dispatch_events: Mix.env() != :prod,
  gateway_intents: [:guilds, :guild_messages, :direct_messages, :message_content]

config :logger, :console,
  level: if(Mix.env() == :prod, do: :info, else: :debug),
  metadata: [:shard, :guild, :channel]

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase
