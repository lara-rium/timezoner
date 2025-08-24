defmodule Timezoner.Repo do
  use Ecto.Repo,
    otp_app: :timezoner,
    adapter: Ecto.Adapters.Postgres
end
