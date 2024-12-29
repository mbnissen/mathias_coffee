defmodule MathiasCoffee.Repo do
  use Ecto.Repo,
    otp_app: :mathias_coffee,
    adapter: Ecto.Adapters.Postgres
end
