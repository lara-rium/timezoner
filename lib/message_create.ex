defmodule Timezoner.MessageCreate do
  alias Nostrum.Api.Message
  alias Timezoner.DatetimeParser
  alias Timezoner.Error
  alias Timezoner.Repo

  def handle(message) do
    # TODO: hi lets meet between 2pm and 3pm is that ok? returns [] while hi lets meet between 2pm 3pm is that ok? works??
    {:ok, parsed} =
      message.content
      |> DatetimeParser.parse()
      |> Error.handle()

    if parsed != [] do
      handle_parsed(parsed, message)
    end
  end

  def handle_parsed(parsed, message) do
    # TODO: handle users with no timezone set
    tz = Repo.Timezone.get(message.author.id).timezone

    dates =
      Enum.map(parsed, fn %{"substring" => substring, "date" => date} ->
        {substring,
         date
         |> NaiveDateTime.from_iso8601!()
         |> DateTime.from_naive!(tz)}
      end)

    content =
      Enum.reduce(dates, message.content, fn {substring, date}, acc ->
        timestamp = DateTime.to_unix(date)
        String.replace(acc, substring, "#{substring} (<t:#{timestamp}>)")
      end)

    message.channel_id
    |> Message.create(content)
    |> Error.handle()

    dates
  end
end
