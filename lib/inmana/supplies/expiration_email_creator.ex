defmodule Inmana.Supplies.ExpirationEmailCreator do
  alias Inmana.Supply
  import Bamboo.Email

  def call(to_email, supplies) do
    new_email(
      to: to_email,
      from: "app@inmana.com",
      subject: "Supplies that are about to expire",
      text_body: email_text(supplies)
    )
  end

  defp email_text(supplies) do
    initial_text = "------- Supplies that are about to expire -------\n"

    supplies
    |> Enum.reduce(initial_text, fn supply, text ->
      text <> supply_string(supply)
    end)
  end

  defp supply_string(%Supply{
    description: description,
    expiration_date: expiration_date,
    responsible: responsible
  }) do
    "Description: #{description} | expiration_date: #{expiration_date} | responsible: #{responsible} \n"
  end
end
