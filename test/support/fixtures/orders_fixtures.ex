defmodule ChpterPhoenix.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChpterPhoenix.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        phone_number: "some phone_number",
        customer_name: "some customer_name",
        customer_email: "some customer_email",
        delivery_location: "some delivery_location"
      })
      |> ChpterPhoenix.Orders.create_order()

    order
  end
end
