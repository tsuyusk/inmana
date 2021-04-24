defmodule Inmana.Supplies.ExpirationNotifier do
  alias Inmana.Supplies.{GetByExpirationDate, ExpirationEmailCreator}
  alias Inmana.Mailer

  def call do
    supplies_close_to_expiration_date = GetByExpirationDate.call

    supplies_close_to_expiration_date
    |> Task.async_stream(fn {to_email, supplies} -> send_email(to_email, supplies) end)
    |> Stream.run()
  end

  defp send_email(to_email, supplies) do
    to_email
    |> ExpirationEmailCreator.call(supplies)
    |> Mailer.deliver_later!()
  end
end
