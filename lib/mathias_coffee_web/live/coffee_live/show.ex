defmodule MathiasCoffeeWeb.CoffeeLive.Show do
  use MathiasCoffeeWeb, :live_view

  alias MathiasCoffee.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:coffee, Inventory.get_coffee!(id))}
  end

  defp page_title(:show), do: "Show Coffee"
  defp page_title(:edit), do: "Edit Coffee"
end
