defmodule MathiasCoffee.Inventory.Coffee do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias MathiasCoffee.Inventory.TasteNote
  alias MathiasCoffee.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "coffees" do
    field :process, :string
    field :variety, :string
    field :region, :string
    field :price, :decimal
    field :altitude, :integer

    many_to_many :taste_notes, TasteNote,
      join_through: "coffees_taste_notes",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  def changeset(coffee, attrs) do
    taste_notes = Map.get(attrs, "taste_notes") || Map.get(attrs, :taste_notes, [])

    coffee
    |> cast(attrs, [:variety, :region, :process, :price, :altitude])
    |> validate_required([:variety, :region, :process, :price, :altitude])
    |> Ecto.Changeset.put_assoc(:taste_notes, Enum.map(taste_notes, &get_or_insert_taste_note/1))
  end

  defp get_or_insert_taste_note(name) do
    Repo.get_by(TasteNote, name: name) ||
      Repo.insert!(%TasteNote{name: name})
  end
end
