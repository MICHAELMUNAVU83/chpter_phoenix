defmodule ChpterPhoenix.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :phone_number, :string
    field :customer_name, :string
    field :customer_email, :string
    field :delivery_location, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:phone_number, :customer_name, :customer_email, :delivery_location])
    |> validate_required([:phone_number, :customer_name, :customer_email, :delivery_location])
    |> validate_format(
      :phone_number,
      ~r/^254\d{9}$/,
      message: "Number has to start with 254 and have 12 digits"
    )
    |> validate_format(:customer_email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
  end
end
