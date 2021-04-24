defmodule Inmana.Supplies.Scheduler do
  alias Inmana.Supplies.ExpirationNotifier
  use GenServer

  # CLIENT

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # SERVER

  @impl true
  def init(state \\ %{}) do
    schedule_notification()

    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    ExpirationNotifier.call()

    schedule_notification()

    {:noreply, state}
  end

  # def handle_cast({:put, key, value}, state) do
  #   {:noreply, Map.put(state, key, value)}
  # end

  # def handle_call({:get, key}, _from, state) do
  #   {:reply, Map.get(state, key), state}
  # end

  defp schedule_notification do
    Process.send_after(self(), :generate, 1000 * 10)
  end
end
