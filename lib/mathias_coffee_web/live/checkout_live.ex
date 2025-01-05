defmodule MathiasCoffeeWeb.CheckoutLive do
  use MathiasCoffeeWeb, :live_view

  @phone_number "4529908631"

  @text """
  Hello Mathias I would like to buy the following items:
  - 1x T-shirt
  - 2x Socks
  - 1x Pants
  """

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto bg-white rounded-lg shadow-lg overflow-hidden mt-4">
      <div class="p-6 text-zinc-600">
        <h1>Checkout</h1>
        <p>Items in cart: {@cart_items}</p>
        <div class="justify-center flex w-full">
          <a
            target="_blank"
            aria-label="Chat on WhatsApp"
            href={"https://wa.me/#{@phone_number}?text=#{@text}"}
          >
            <img alt="Chat on WhatsApp" src={~p"/images/WhatsAppButtonGreenSmall.png"} />
          </a>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    text =
      URI.encode(@text)
      |> dbg()

    {:ok, assign(socket, cart_items: 0, phone_number: @phone_number, text: text)}
  end

  @impl true
  def handle_event("checkout", _value, socket) do
    {:noreply, assign(socket, cart_items: 0)}
  end
end
