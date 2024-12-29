defmodule MathiasCoffeeWeb.PageLive do
  use MathiasCoffeeWeb, :live_view

  alias MathiasCoffee.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :coffees, Inventory.list_coffees())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section id="menu">
      <div class="container mx-auto px-6">
        <h3 class="text-4xl font-bold text-center">Mathias Coffee</h3>
        <p class="text-6xl text-center">
          ☕️
        </p>
        <div class="pt-3">
          <div class="text-center">
            <p>
              All prices are per 100 grams.
            </p>
            <p>
              Weight of each batch pre-roast. The final weight varies, but is usually around 90 grams.
            </p>
          </div>
          <%= for {_id, coffee} <- @streams.coffees do %>
            <div class="mx-auto bg-white rounded-lg shadow-lg overflow-hidden mt-4">
              <div class="p-6">
                <h2 class="text-xl font-bold text-zinc-600">
                  {coffee.variety}
                </h2>
                <p class="mt-1 text-zinc-500">
                  <span><.flag region={coffee.region} /></span> • <span>{coffee.process}</span>
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
