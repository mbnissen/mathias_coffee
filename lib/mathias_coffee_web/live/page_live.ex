defmodule MathiasCoffeeWeb.PageLive do
  use MathiasCoffeeWeb, :live_view

  alias MathiasCoffee.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :coffees, Inventory.list_coffees())}
  end

  @impl true
  def handle_event("add_to_cart", %{"id" => id}, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section id="menu">
      <div class="container mx-auto px-6">
        <div class="pb-10">
          <div class="text-center">
            <p>
              All prices are per 100 grams.
            </p>
            <p>
              Weight of each batch pre-roast. The final weight varies, but is usually around 90 grams.
            </p>
          </div>
          <div>
            <%= for {_id, coffee} <- @streams.coffees do %>
              <div class="mx-auto bg-white rounded-lg shadow-lg overflow-hidden mt-4">
                <div class="p-6">
                  <h2 class="text-xl font-bold text-zinc-600">
                    {coffee.variety}
                  </h2>
                  <p class="mt-1 text-zinc-500">
                    <span><.flag region={coffee.region} /></span> • <span>{coffee.process}</span>
                  </p>
                  <div class="pt-2 flex justify-between">
                    <div>
                      <p class="text-lg pt-2 font-bold text-zinc-600">{coffee.price} kr.</p>
                    </div>
                    <div>
                      <.button class="text-xs" phx-click="add_to_cart" phx-value-id={coffee.id}>
                        Add to cart
                      </.button>
                    </div>
                  </div>
                </div>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
