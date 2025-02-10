defmodule MathiasCoffee.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false

  alias MathiasCoffee.Inventory.Coffee
  alias MathiasCoffee.Repo

  @doc """
  Returns the list of coffees.

  ## Examples

      iex> list_coffees()
      [%Coffee{}, ...]

  """
  def list_coffees do
    Coffee |> Repo.all() |> Repo.preload(:taste_notes)
  end

  @doc """
  Gets a single coffee.

  Raises `Ecto.NoResultsError` if the Coffee does not exist.

  ## Examples

      iex> get_coffee!(123)
      %Coffee{}

      iex> get_coffee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_coffee!(id), do: Coffee |> Repo.get!(id) |> Repo.preload(:taste_notes)

  @doc """
  Creates a coffee.

  ## Examples

      iex> create_coffee(%{field: value})
      {:ok, %Coffee{}}

      iex> create_coffee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_coffee(attrs \\ %{}) do
    %Coffee{}
    |> Coffee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a coffee.

  ## Examples

      iex> update_coffee(coffee, %{field: new_value})
      {:ok, %Coffee{}}

      iex> update_coffee(coffee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_coffee(%Coffee{} = coffee, attrs) do
    coffee
    |> Coffee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a coffee.

  ## Examples

      iex> delete_coffee(coffee)
      {:ok, %Coffee{}}

      iex> delete_coffee(coffee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_coffee(%Coffee{} = coffee) do
    Repo.delete(coffee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking coffee changes.

  ## Examples

      iex> change_coffee(coffee)
      %Ecto.Changeset{data: %Coffee{}}

  """
  def change_coffee(%Coffee{} = coffee, attrs \\ %{}) do
    Coffee.changeset(coffee, attrs)
  end
end
