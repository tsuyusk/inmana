defmodule Inmana.Welcomer do
  def welcome(%{"name" => name, "age" => age}) do
    age =
      age
      |> String.to_integer()

    name
    |> String.downcase()
    |> String.trim()
    |> evaluate(age)
  end

  defp evaluate("banana", 42) do
    {:ok, "You're very special"}
  end

  defp evaluate(name, age) when age >= 18 do
    {:ok, "Welcome, #{name}"}
  end

  defp evaluate(name, _age) do
    {:error, "You shall not pass #{name} "}
  end
end
