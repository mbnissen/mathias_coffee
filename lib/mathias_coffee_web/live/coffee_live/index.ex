defmodule MathiasCoffeeWeb.CoffeeLive.Index do
  use MathiasCoffeeWeb, :live_view

  alias MathiasCoffee.Inventory
  alias MathiasCoffee.Inventory.Coffee

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :coffees, Inventory.list_coffees())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Coffee")
    |> assign(:coffee, Inventory.get_coffee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Coffee")
    |> assign(:coffee, %Coffee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Coffees")
    |> assign(:coffee, nil)
  end

  @impl true
  def handle_info({MathiasCoffeeWeb.CoffeeLive.FormComponent, {:saved, coffee}}, socket) do
    {:noreply, stream_insert(socket, :coffees, coffee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    coffee = Inventory.get_coffee!(id)
    {:ok, _} = Inventory.delete_coffee(coffee)

    {:noreply, stream_delete(socket, :coffees, coffee)}
  end
end
