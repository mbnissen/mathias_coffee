defmodule MathiasCoffeeWeb.Nav do
  @moduledoc false
  use MathiasCoffeeWeb, :live_component

  alias MathiasCoffeeWeb.ShoppingCart

  def on_mount(:default, _params, session, socket) do
    ShoppingCart.init(session)
    cart_items = ShoppingCart.get_items(session)

    {:cont,
     socket
     |> assign(:cart_items, cart_items)
     |> assign(:token, session["_csrf_token"])
     |> attach_hook(:add_to_cart, :handle_event, &handle_event/3)}
  end

  defp handle_event("increment_item", %{"id" => id}, socket) do
    cart_items = ShoppingCart.increment_item_in_cart(id, socket.assigns.token)
    {:cont, assign(socket, :cart_items, cart_items)}
  end

  defp handle_event("decrement_item", %{"id" => id}, socket) do
    cart_items = ShoppingCart.decrement_item_in_cart(id, socket.assigns.token)
    {:cont, assign(socket, :cart_items, cart_items)}
  end

  defp handle_event("remove_from_cart", %{"id" => id}, socket) do
    cart_items = ShoppingCart.delete_item_from_cart(id, socket.assigns.token)
    {:cont, assign(socket, :cart_items, cart_items)}
  end

  defp handle_event("empty_cart", _, socket) do
    ShoppingCart.clearCache()
    {:cont, assign(socket, :cart_items, [])}
  end

  defp handle_event(_, _, socket) do
    {:cont, socket}
  end
end
