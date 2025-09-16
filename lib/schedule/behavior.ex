defmodule Timezoner.Schedule.Behaviour do
  @callback task() :: any()

  defmacro __using__(_) do
    quote do
      use GenServer
      @behaviour Timezoner.Schedule.Behaviour

      def start_link(_) do
        GenServer.start_link(__MODULE__, nil, name: __MODULE__)
      end

      def init(_) do
        {:ok, nil}
      end

      def handle_cast(:task, _) do
        task()

        10
        |> :timer.seconds()
        |> :timer.apply_after(&GenServer.cast/2, [__MODULE__, :task])

        {:noreply, nil}
      end

      def start do
        GenServer.cast(__MODULE__, :task)
      end
    end
  end
end
