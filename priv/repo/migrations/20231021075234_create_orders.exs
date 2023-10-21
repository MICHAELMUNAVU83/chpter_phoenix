defmodule ChpterPhoenix.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :phone_number, :string
      add :customer_name, :string
      add :customer_email, :string
      add :delivery_location, :string

      timestamps()
    end
  end
end
