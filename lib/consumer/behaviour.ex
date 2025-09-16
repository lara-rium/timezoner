defmodule Timezoner.Consumer.Behaviour do
  @callback handle(any()) :: any()
end
