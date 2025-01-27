defmodule MathiasCoffeeWeb.CoffeeLive.Index do
  @moduledoc false
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

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded-md shadow-lg p-4">
      <.header>
        Listing Coffees
        <:actions>
          <.link patch={~p"/admin/coffees/new"}>
            <.button>New Coffee</.button>
          </.link>
        </:actions>
      </.header>

      <.table id="coffees" rows={@streams.coffees}>
        <:col :let={{_id, coffee}}>
          <span>{coffee.variety}</span> <br />
          <span><.flag region={coffee.region} /></span> <br />
          <span>{coffee.process}</span>
        </:col>
        <:action :let={{_id, coffee}}>
          <.link patch={~p"/admin/coffees/#{coffee}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, coffee}}>
          <.link
            phx-click={JS.push("delete", value: %{id: coffee.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>

      <.modal
        :if={@live_action in [:new, :edit]}
        id="coffee-modal"
        show
        on_cancel={JS.patch(~p"/admin")}
      >
        <.live_component
          module={MathiasCoffeeWeb.CoffeeLive.FormComponent}
          id={@coffee.id || :new}
          title={@page_title}
          action={@live_action}
          coffee={@coffee}
          patch={~p"/admin"}
        />
      </.modal>
    </div>
    """
  end
end
