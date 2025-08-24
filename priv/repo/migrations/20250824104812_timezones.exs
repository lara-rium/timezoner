defmodule Timezoner.Repo.Migrations.Timezones do
  use Ecto.Migration

  def change do
    create table(:timezones, primary_key: false) do
      add :user_id, :bigint, null: false, primary_key: true
      add :timezone, :string, null: false
    end
  end
end
