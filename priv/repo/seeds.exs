# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MathiasCoffee.Repo.insert!(%MathiasCoffee.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

coffees = [
  %{
    region: "Colombia",
    farm: "El Diviso",
    variety: "Caturra Chiroso",
    process: "Washed Anaerobic",
    price: 70
  },
  %{
    region: "Colombia",
    farm: "Yoiner",
    variety: "Pink Bourbon",
    process: "Natural",
    price: 55
  },
  %{
    region: "Costa Rica",
    farm: "Monte Brisas",
    variety: "Geisha",
    process: "Washed",
    price: 65
  },
  %{
    region: "Costa Rica",
    farm: "Solis and Cordero",
    variety: "Catuai",
    process: "Natural Anaerobic",
    price: 50
  },
  %{
    region: "Costa Rica",
    farm: "Sonora",
    variety: "Villa Sarchi",
    process: "Natural",
    price: 45
  },
  %{
    region: "Costa Rica",
    farm: "Finca Carrizal",
    variety: "Caturra",
    process: "Red Honey",
    price: 45
  },
  %{
    region: "Guatemala",
    farm: "Soledad",
    variety: "Geisha",
    process: "Washed",
    price: 65
  },
  %{
    region: "Ethiopia",
    farm: "Chelbesa",
    variety: "Heirloom",
    process: "Dry Fermentation Washed",
    price: 55
  },
  %{
    region: "Kenya",
    farm: "Thimu",
    variety: "SL28, SL34, SL Grafted, Ruiru 11 & Batian",
    process: "Washed",
    price: 50
  }
]

alias MathiasCoffee.Inventory

Enum.each(coffees, fn coffee ->
  Inventory.create_coffee(coffee)
end)
