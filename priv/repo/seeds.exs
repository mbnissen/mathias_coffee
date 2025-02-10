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

alias MathiasCoffee.Inventory

coffees = [
  %{
    region: "Colombia",
    farm: "El Diviso",
    variety: "Caturra Chiroso",
    process: "Washed Anaerobic",
    price: 70,
    altitude: 1800,
    taste_notes: ["Blackberry", "Caramel", "Floral", "Lemon", "Peach", "Strawberry", "Vanilla"]
  },
  %{
    region: "Colombia",
    farm: "Yoiner",
    variety: "Pink Bourbon",
    process: "Natural",
    price: 55,
    altitude: 1800,
    taste_notes: ["Strawberry", "Peach", "Caramel"]
  },
  %{
    region: "Costa Rica",
    farm: "Monte Brisas",
    variety: "Geisha",
    process: "Washed",
    price: 65,
    altitude: 1800,
    taste_notes: ["Jasmine", "Peach", "Lemon"]
  },
  %{
    region: "Costa Rica",
    farm: "Solis and Cordero",
    variety: "Catuai",
    process: "Natural Anaerobic",
    price: 50,
    altitude: 1800,
    taste_notes: ["Blackberry", "Caramel", "Floral"]
  },
  %{
    region: "Costa Rica",
    farm: "Sonora",
    variety: "Villa Sarchi",
    process: "Natural",
    price: 45,
    altitude: 1800,
    taste_notes: ["Strawberry", "Peach", "Caramel"]
  },
  %{
    region: "Costa Rica",
    farm: "Finca Carrizal",
    variety: "Caturra",
    process: "Red Honey",
    price: 45,
    altitude: 1800,
    taste_notes: ["Blackberry", "Caramel", "Floral"]
  },
  %{
    region: "Guatemala",
    farm: "Soledad",
    variety: "Geisha",
    process: "Washed",
    price: 65,
    altitude: 1800,
    taste_notes: ["Jasmine", "Peach", "Lemon"]
  },
  %{
    region: "Ethiopia",
    farm: "Chelbesa",
    variety: "Heirloom",
    process: "Dry Fermentation Washed",
    price: 55,
    altitude: 1800,
    taste_notes: ["Blackberry", "Caramel", "Floral"]
  },
  %{
    region: "Kenya",
    farm: "Thimu",
    variety: "SL28, SL34, SL Grafted, Ruiru 11 & Batian",
    process: "Washed",
    price: 50,
    altitude: 1800
  }
]

Enum.each(coffees, fn coffee ->
  Inventory.create_coffee(coffee)
end)
