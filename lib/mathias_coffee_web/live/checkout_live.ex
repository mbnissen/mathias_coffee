defmodule MathiasCoffeeWeb.CheckoutLive do
  use MathiasCoffeeWeb, :live_view

  alias MathiasCoffeeWeb.ShoppingCart

  @phone_number "4529908631"

  @text """
  Hello Mathias I would like to buy the following items:
  - 1x T-shirt
  - 2x Socks
  - 1x Pants
  """

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:phone_number, @phone_number)
     |> assign(text: @text)}
  end

  @impl true
  def handle_event("checkout", _value, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto bg-white rounded-lg shadow-lg overflow-hidden mt-4">
      <div class="p-6 text-zinc-600">
        <div class="container mx-auto p-6">
          <header class="mb-8">
            <h1 class="text-2xl font-bold text-gray-800">Shopping Cart</h1>
          </header>

          <div class="bg-white rounded-lg shadow p-6">
            <div class="mb-4 border-b pb-4">
              <div class="flex justify-between items-center">
                <div>
                  <h2 class="text-lg font-semibold text-gray-800">Product Name</h2>
                  <p class="text-sm text-gray-500">Product description goes here.</p>
                </div>
                <div class="flex items-center space-x-4">
                  <input
                    type="number"
                    value="1"
                    min="1"
                    class="w-16 border-gray-300 rounded text-center"
                  />
                  <p class="text-gray-800 font-semibold">$29.99</p>
                  <button class="text-red-500 hover:underline">Remove</button>
                </div>
              </div>
            </div>

            <div class="mb-4 border-b pb-4">
              <div class="flex justify-between items-center">
                <div>
                  <h2 class="text-lg font-semibold text-gray-800">Another Product</h2>
                  <p class="text-sm text-gray-500">Another description here.</p>
                </div>
                <div class="flex items-center space-x-4">
                  <input
                    type="number"
                    value="2"
                    min="1"
                    class="w-16 border-gray-300 rounded text-center"
                  />
                  <p class="text-gray-800 font-semibold">$49.99</p>
                  <button class="text-red-500 hover:underline">Remove</button>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-6 bg-white rounded-lg shadow p-6">
            <div class="flex justify-between items-center mb-4">
              <p class="text-gray-800">Subtotal</p>
              <p class="text-gray-800 font-semibold">$129.97</p>
            </div>
            <div class="flex justify-between items-center mb-4">
              <p class="text-gray-800">Tax (10%)</p>
              <p class="text-gray-800 font-semibold">$12.99</p>
            </div>
            <div class="flex justify-between items-center border-t pt-4">
              <p class="text-xl font-bold text-gray-800">Total</p>
              <p class="text-xl font-bold text-gray-800">$142.96</p>
            </div>
            <div class="pt-4">
              <p>To order send a message using one of the messaging services below</p>
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
        </div>
      </div>
    </div>
    """
  end
end
