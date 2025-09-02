defmodule Timezoner.Interactions do
  alias Nostrum.Api.ApplicationCommand
  alias Timezoner.Error

  def commands do
    [Timezoner.Interactions.Help, Timezoner.Interactions.Timezone]
  end

  def command_ids do
    Application.get_env(:timezoner, :command_ids, %{})
  end

  def register do
    guild_id = Application.get_env(:timezoner, :guild_id)
    commands = Enum.map(commands(), fn cmd -> cmd.command() end)

    if guild_id do
      guild_id
      |> ApplicationCommand.bulk_overwrite_guild_commands(commands)
      |> Error.handle()
    end

    {:ok, commands_response} =
      commands
      |> ApplicationCommand.bulk_overwrite_global_commands()
      |> Error.handle()

    command_ids = Map.new(commands_response, &{&1.name, &1.id})

    Application.put_env(:timezoner, :command_ids, command_ids)
  end

  def handle(interaction) do
    command =
      Enum.find(commands(), fn cmd -> cmd.name() == interaction.data.name end)

    command.handle(interaction)
  end
end
