defmodule ChpterPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :chpter_phoenix,
    adapter: Ecto.Adapters.Postgres
end
