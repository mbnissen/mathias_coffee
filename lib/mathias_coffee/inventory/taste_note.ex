defmodule MathiasCoffee.Inventory.TasteNote do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  @foreign_key_type :binary_id
  schema "taste_notes" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end
end
