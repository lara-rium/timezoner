defmodule Timezoner.Repo.Timezone do
  use Ecto.Schema

  alias Timezoner.Repo

  @primary_key {:user_id, :integer, autogenerate: false}
  schema "timezones" do
    field :timezone, :string
  end

  def insert(user_id, tz) do
    Repo.insert!(%__MODULE__{user_id: user_id, timezone: tz},
      on_conflict: :replace_all,
      conflict_target: :user_id
    )
  end

  def get(user_id) do
    Repo.get(__MODULE__, user_id)
  end
end
