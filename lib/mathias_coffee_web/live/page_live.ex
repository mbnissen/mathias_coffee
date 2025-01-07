defmodule MathiasCoffeeWeb.PageLive do
  use MathiasCoffeeWeb, :live_view

  alias MathiasCoffee.Inventory

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign(:coffees, Inventory.list_coffees())}
  end

  @impl true
  def handle_event(_, _params, socket) do
    # Handled in Nav
    {:noreply, socket}
  end

  defp get_cart_item_count(id, cart_items) do
    case Enum.find(cart_items, &(&1.id == id)) do
      nil -> 0
      cart_item -> cart_item.count
    end
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
            <%= for coffee <- @coffees do %>
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
                      <p class="text-lg pt-2 font-bold text-zinc-600">
                        <.price amount={coffee.price} /> / 100 g.
                      </p>
                    </div>
                    <div class="flex items-center space-x-2 pt-1">
                      <div phx-click="decrement_item" phx-value-id={coffee.id}>
                        <.icon name="hero-minus-circle" class="text-zinc-600 cursor-pointer" />
                      </div>
                      <span class="text-zinc-700 w-8 text-center border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        {get_cart_item_count(coffee.id, @cart_items)}
                      </span>
                      <div phx-click="increment_item" phx-value-id={coffee.id}>
                        <.icon name="hero-plus-circle" class="text-zinc-600 cursor-pointer" />
                      </div>
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
