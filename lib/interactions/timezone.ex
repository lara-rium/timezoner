# credo:disable-for-next-line Credo.Check.Refactor.ModuleDependencies
defmodule Timezoner.Interactions.Timezone do
  @behaviour Timezoner.Interactions.Behaviour

  alias Nostrum.Api.Interaction
  alias Nostrum.Constants.ApplicationCommandOptionType
  alias Nostrum.Constants.ApplicationCommandType
  alias Timezoner.Builder.Component
  alias Timezoner.Builder.InteractionResponse
  alias Timezoner.Error
  alias Timezoner.Repo

  @impl Timezoner.Interactions.Behaviour
  def name, do: "timezone"

  @impl Timezoner.Interactions.Behaviour
  def command do
    option = %{
      name: "city",
      description: "Your city",
      type: ApplicationCommandOptionType.string(),
      required: true
    }

    %{
      name: name(),
      description: "Set your timezone to send times",
      type: ApplicationCommandType.chat_input(),
      options: [option]
    }
  end

  @impl Timezoner.Interactions.Behaviour
  def handle(interaction) do
    city = List.first(interaction.data.options).value

    response =
      city
      |> Geocoder.call()
      |> response(interaction.user.id)

    interaction
    |> Interaction.create_response(response)
    |> Error.handle()
  end

  def response({:ok, %Geocoder.Coords{lat: lat, lon: lon}}, user_id) do
    {:ok, tz} =
      {lon, lat}
      |> TzWorld.timezone_at()
      |> Error.handle()

    Repo.Timezone.insert(user_id, tz)

    InteractionResponse.channel_message_with_source([
      Component.section("https://cdn.lara.lv/emoji/partying-face.webp", [
        Component.text("# Timezone set"),
        Component.text(
          "I set your timezone to **#{tz}**. Now, you can convert times however you want!"
        )
      ])
    ])
  end

  def response({:error, _}, _) do
    title_section =
      Component.section("https://cdn.lara.lv/emoji/pensive.webp", [
        Component.text("# City not found"),
        Component.text("I couldn't find that city, please make sure you spelled it correctly.")
      ])

    footer_text =
      Component.text(
        "-# If you spelled it right, make sure the city that you're living in actually exists."
      )

    InteractionResponse.channel_message_with_source([
      title_section,
      footer_text
    ])
  end
end
