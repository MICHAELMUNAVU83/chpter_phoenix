defmodule ChpterPhoenix.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChpterPhoenix.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        message: "some message",
        status: 42,
        success: true,
        amount: "some amount",
        transaction_code: "some transaction_code",
        transaction_reference: "some transaction_reference"
      })
      |> ChpterPhoenix.Transactions.create_transaction()

    transaction
  end
end
