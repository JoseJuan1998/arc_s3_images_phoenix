defmodule Teacher.PurchasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Teacher.Purchases` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        stripe_customer_id: "some stripe_customer_id"
      })
      |> Teacher.Purchases.create_customer()

    customer
  end
end
