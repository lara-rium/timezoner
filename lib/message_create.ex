defmodule Timezoner.MessageCreate do
  alias Nostrum.Api.Message
  alias Timezoner.Duckling
  alias Timezoner.Error
  alias Timezoner.Repo

  def handle(message) do
    parsed = Duckling.parse(message.content)

    if parsed != [] do
      # TODO: handle users with no timezone set
      # TODO: delete original message
      tz = Repo.Timezone.get(message.author.id).timezone

      content =
        parsed
        |> Enum.sort_by(& &1["end"], :desc)
        |> Enum.reduce(message.content, &add_timestamp(&1, &2, tz))

      message.channel_id
      |> Message.create(content)
      |> Error.handle()
    end
  end

  def add_timestamp(date_body, acc, tz) do
    values =
      Enum.reject(
        [
          date_body["value"]["value"],
          date_body["value"]["from"]["value"],
          date_body["value"]["to"]["value"]
        ],
        &is_nil(&1)
      )

    grain = date_body["value"]["grain"]

    dates =
      Enum.map(values, fn value ->
        value
        |> NaiveDateTime.from_iso8601!()
        |> DateTime.from_naive!(tz)
      end)

    timestamps =
      Enum.map_join(dates, "-", fn date ->
        "<t:#{DateTime.to_unix(date)}:#{format(date, grain, tz)}>"
      end)

    {before_end, after_end} = String.split_at(acc, date_body["end"])
    before_end <> " (#{timestamps})" <> after_end
  end

  defp format(date, grain, tz) do
    case {DateTime.to_date(date) ==
            tz
            |> DateTime.now!()
            |> DateTime.to_date(), grain} do
      {true, "second"} -> "T"
      {true, _} -> "t"
      {false, grain} when grain in ["hour", "minute", "second"] -> "f"
      {false, _} -> "D"
    end
  end
end
