defmodule Timezoner.Consumer do
  use Nostrum.Consumer

  alias Timezoner.Consumer

  def handle_event({:READY, _, _}) do
    Consumer.Ready.handle(nil)
  end

  def handle_event({:INTERACTION_CREATE, interaction, _}) do
    Consumer.InteractionCreate.handle(interaction)
  end

  def handle_event({:MESSAGE_CREATE, message, _}) do
    Consumer.MessageCreate.handle(message)
  end

  def handle_event({:MESSAGE_UPDATE, {_, message}, _}) do
    Consumer.MessageCreate.handle(message)
  end
end
