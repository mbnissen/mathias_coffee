defmodule MathiasCoffee.Inventory.Coffee do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "coffees" do
    field :process, :string
    field :variety, :string
    field :region, :string
    field :price, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(coffee, attrs) do
    coffee
    |> cast(attrs, [:variety, :region, :process, :price])
    |> validate_required([:variety, :region, :process, :price])
  end
end
