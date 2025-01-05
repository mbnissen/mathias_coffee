defmodule MathiasCoffeeWeb.Nav do
  use MathiasCoffeeWeb, :live_component

  alias MathiasCoffeeWeb.ShoppingCart

  def on_mount(:default, _params, session, socket) do
    ShoppingCart.init(session)

    {:cont,
     socket
     |> assign_new(:cart_items, fn ->
       ShoppingCart.get_items(session)
     end)
     |> attach_hook(:ping, :handle_event, &handle_event/3)}
  end

  defp handle_event("add_to_cart", %{"id" => id}, socket) do
    items =
      ShoppingCart.increment_item_in_cart(id, socket.assigns.token)
      |> dbg()

    {:cont, socket |> assign(:items, items)}
  end

  defp handle_event(_, _, socket) do
    {:cont, socket}
  end
end
