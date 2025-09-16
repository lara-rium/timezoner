defmodule Timezoner.Consumer do
  use Nostrum.Consumer

  alias Timezoner.Interactions
  alias Timezoner.Schedule

  def handle_event({:READY, _, _}) do
    Interactions.register()

    Schedule.UpdateStatus.start()
    Schedule.UpdateTzWorld.start()
  end

  def handle_event({:INTERACTION_CREATE, interaction, _}) do
    Interactions.handle(interaction)
  end

  def handle_event({:MESSAGE_CREATE, message, _}) do
    Timezoner.MessageCreate.handle(message)
  end

  def handle_event({:MESSAGE_UPDATE, {_, message}, _}) do
    Timezoner.MessageCreate.handle(message)
  end
end
