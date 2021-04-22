defmodule Inmana.Supplies.Get do
  alias Inmana.{Repo,Supply}

  def call(uuid) do
    Repo.get(Supply, uuid)
    |> handle_get()
  end

  defp handle_get(%Supply{} = supply), do: {:ok, supply}
  defp handle_get(nil), do: {:error, %{result: "Invalid Id"}}
end
