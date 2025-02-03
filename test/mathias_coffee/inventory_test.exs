defmodule MathiasCoffee.InventoryTest do
  use MathiasCoffee.DataCase

  alias MathiasCoffee.Inventory
  alias MathiasCoffee.Inventory.Coffee

  describe "inventory" do
    test "create_coffee/1 with valid data creates a coffee" do
      valid_attrs = %{
        region: "Colombia",
        farm: "El Diviso",
        variety: "Caturra Chiroso",
        process: "Washed Anaerobic",
        price: 70,
        altitude: 1800,
        taste_notes: ["Blackberry", "Caramel", "Floral"]
      }

      assert {:ok, %Coffee{} = _coffee} = Inventory.create_coffee(valid_attrs)
    end

    test "create_coffee/1 with no taste notes" do
      valid_attrs = %{
        region: "Colombia",
        farm: "El Diviso",
        variety: "Caturra Chiroso",
        process: "Washed Anaerobic",
        price: 70,
        altitude: 1800
      }

      assert {:ok, %Coffee{} = _coffee} = Inventory.create_coffee(valid_attrs)
    end
  end
end
