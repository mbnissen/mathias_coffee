defmodule MathiasCoffee.Repo.Migrations.CreateCoffees do
  use Ecto.Migration

  def change do
    create table(:coffees, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :variety, :string
      add :region, :string
      add :process, :string
      add :price, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
