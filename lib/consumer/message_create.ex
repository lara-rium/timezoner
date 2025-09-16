defmodule Timezoner.Consumer.MessageCreate do
  @behaviour Timezoner.Consumer.Behaviour

  alias Nostrum.Api.Message
  alias Timezoner.Builder.Component
  alias Timezoner.ConvertTime
  alias Timezoner.Error
  alias Timezoner.Repo

  def handle(message) when message.author.bot, do: :ok

  def handle(message) do
    parsed = ConvertTime.parse(message.content)

    handle(message, parsed)
  end

  def handle(_, []), do: :ok

  def handle(message, parsed) do
    tz_record = Repo.Timezone.get(message.author.id)

    handle(message, parsed, tz_record)
  end

  def handle(message, _, nil) do
    title_section =
      Component.section("https://cdn.lara.lv/emoji/wave.webp", [
        Component.text("# Want to ditch timezones?"),
        Component.text(
          "I detected times in your message, would you like people to see them in their own timezone?"
        )
      ])

    command_id = Timezoner.Interactions.command_ids()["timezone"]

    description_text =
      Component.text(
        "Don't worry, it's super easy! Just press </timezone:#{command_id}> and type your city."
      )

    footer_text = Component.text("-# Thanks to magic, readers don't even need to do anything!")

    message.channel_id
    |> Component.create_message([title_section, description_text, footer_text])
    |> Error.handle()
  end

  def handle(message, parsed, tz_record) do
    content = ConvertTime.convert(message.content, parsed, tz_record.timezone)

    message.channel_id
    |> Message.create(content)
    |> Error.handle()
  end
end
