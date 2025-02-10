defmodule MathiasCoffee.Repo.Migrations.AddTasteNotesAndAltitudeToCoffee do
  use Ecto.Migration

  def change do
    alter table(:coffees) do
      add :altitude, :integer
    end

    create table(:taste_notes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:taste_notes, [:name])

    create table(:coffees_taste_notes, primary_key: false) do
      add :coffee_id, :binary_id, references: :coffees
      add :taste_note_id, :binary_id, references: :taste_notes
    end
  end
end
