defmodule Timezoner.Interactions do
  use Larabot.Interactions

  alias Nostrum.Api.ApplicationCommand

  def commands, do: [Timezoner.Interactions.Help, Timezoner.Interactions.Timezone]
end
