defmodule Timezoner.Consumer.InteractionCreate do
  @behaviour Timezoner.Consumer.Behaviour

  def handle(interaction) do
    command =
      Enum.find(Timezoner.Interactions.commands(), fn cmd ->
        cmd.name() == interaction.data.name
      end)

    command.handle(interaction)
  end
end
