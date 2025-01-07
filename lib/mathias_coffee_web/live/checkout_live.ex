defmodule MathiasCoffeeWeb.CheckoutLive do
  use MathiasCoffeeWeb, :live_view

  @phone_number "4529908631"

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:phone_number, @phone_number)}
  end

  @impl true
  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end

  defp calculate_total(cart_items) do
    cart_items
    |> Enum.reduce(0, fn %{coffee: coffee, count: count}, acc ->
      Decimal.add(acc, Decimal.mult(coffee.price, count))
    end)
  end

  defp encode_text(card_items) do
    lines =
      Enum.map(card_items, fn %{coffee: coffee, count: count} ->
        """
        - #{count} x #{coffee.variety} - #{Decimal.mult(coffee.price, count)} kr.
        """
      end)

    """
    Hello Mathias I would like to buy the following coffees:
     
    #{lines}
    Total: #{calculate_total(card_items)} kr.
    """
    |> URI.encode()
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
    <div class="mx-auto bg-white rounded-lg shadow-lg overflow-hidden mt-4">
      <div class="p-6 text-zinc-600">
        <div class="container mx-auto p-6">
          <div class="bg-white rounded-lg shadow p-6">
            <%= for %{coffee: coffee, count: count} <- @cart_items do %>
              <div class="mb-4 border-b pb-4">
                <div class="flex justify-between items-center">
                  <div>
                    <h2 class="text-lg font-semibold text-gray-800">{count} x {coffee.variety}</h2>
                    <p class="text-sm text-gray-500">{coffee.region} - {coffee.process}</p>
                  </div>
                  <div class="flex items-center space-x-4">
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
                    <p class="text-gray-800 font-semibold">
                      <.price amount={Decimal.mult(coffee.price, count)} />
                    </p>
                    <span
                      phx-click="remove_from_cart"
                      phx-value-id={coffee.id}
                      class="text-red-500 cursor-pointer"
                    >
                      <.icon name="hero-trash" class="h-6 w-6" />
                    </span>
                  </div>
                </div>
              </div>
            <% end %>
            <div class="flex justify-between items-center pt-4">
              <p class="text-xl font-bold text-gray-800">Total</p>
              <p class="text-xl font-bold text-gray-800">
                <.price amount={calculate_total(@cart_items)} />
              </p>
            </div>
            <div class="pt-8">
              <p>To order send a message using one of the messaging services below</p>
              <div class="justify-center flex w-full pt-4">
                <a
                  target="_blank"
                  aria-label="Chat on WhatsApp"
                  href={"https://wa.me/#{@phone_number}?text=#{encode_text(@cart_items)}"}
                >
                  <img alt="Chat on WhatsApp" src={~p"/images/WhatsAppButtonGreenSmall.png"} />
                </a>
              </div>
              <div class="pt-8">
                <.button phx-click="empty_cart" class="ml-4 w-full">
                  Empty shopping cart
                </.button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
