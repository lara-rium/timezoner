defmodule Timezoner.Duckling do
  def parse(text) do
    response =
      HTTPoison.post!(
        "http://0.0.0.0:8000/parse",
        {:form, [text: text]},
        [],
        hackney: [pool: :default]
      )

    Jason.decode!(response.body)
  end
end
