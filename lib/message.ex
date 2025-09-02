defmodule Timezoner.Message do
  import Bitwise

  alias Nostrum.Api.Message

  def create(channel_id, components) do
    Message.create(channel_id, %{components: components, flags: 1 <<< 15})
  end
end
