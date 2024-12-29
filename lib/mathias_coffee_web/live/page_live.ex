defmodule MathiasCoffeeWeb.PageLive do
  use MathiasCoffeeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # Region	Variety	Process	Price (100g)*

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
      # %{
      #  region: "Kenya",
      #  farm: "Kii",
      #  variety: "SL28 & SL34",
      #  process: "Washed",
      #  price: "Sold out"
      # },
      %{
        region: "Kenya",
        farm: "Thimu",
        variety: "SL28, SL34, SL Grafted, Ruiru 11 & Batian",
        process: "Washed",
        price: 50
      }
    ]

    {:ok, socket |> assign(coffees: coffees)}
  end

  defp flag(country) do
    case country do
      "Colombia" -> "🇨🇴"
      "Costa Rica" -> "🇨🇷"
      "Guatemala" -> "🇬🇹"
      "Ethiopia" -> "🇪🇹"
      "Kenya" -> "🇰🇪"
      _ -> ""
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section id="menu">
      <div class="container mx-auto px-6">
        <h3 class="text-6xl font-bold text-center">Mathias Coffee ☕</h3>

        <div class="pt-6">
          <div class="text-center">
            <p>
              All prices are per 100 grams.
            </p>
            <p>
              Weight of each batch pre-roast. The final weight varies, but is usually around 90 grams.
            </p>
          </div>
          <%= for coffee <- @coffees do %>
            <div class="mx-auto bg-white rounded-lg shadow-lg overflow-hidden mt-4">
              <div class="p-6">
                <h2 class="text-xl font-bold text-zinc-600">
                  {coffee.variety}
                </h2>
                <p class="mt-1 text-zinc-500">
                  <span>{flag(coffee.region)} {coffee.region}</span> • <span>{coffee.process}</span>
                </p>
                <p class="mt-4 text-lg font-bold text-zinc-600">{coffee.price} kr.</p>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end
end
