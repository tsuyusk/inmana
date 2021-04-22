defmodule Inmana.Supplies.ExpirationNotifier do
  alias Inmana.Mailer
  alias Inmana.Supplies.{GetByExpirationDate, ExpirationEmailCreator}

  def call do
    supplies_clsoe_to_expiration_date = GetByExpirationDate.call

    Enum.each(supplies_clsoe_to_expiration_date, fn {to_email, supplies} ->
       to_email
       |> ExpirationEmailCreator.call(supplies)
       |> Mailer.deliver_later!()
    end)
  end
end
