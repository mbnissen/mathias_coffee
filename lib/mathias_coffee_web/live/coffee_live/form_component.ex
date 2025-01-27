defmodule MathiasCoffeeWeb.CoffeeLive.FormComponent do
  @moduledoc false
  use MathiasCoffeeWeb, :live_component

  alias MathiasCoffee.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage coffee records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="coffee-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:variety]} type="text" label="Variety" />
        <.input field={@form[:region]} type="text" label="Region" />
        <.input field={@form[:process]} type="text" label="Process" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Coffee</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{coffee: coffee} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Inventory.change_coffee(coffee))
     end)}
  end

  @impl true
  def handle_event("validate", %{"coffee" => coffee_params}, socket) do
    changeset = Inventory.change_coffee(socket.assigns.coffee, coffee_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"coffee" => coffee_params}, socket) do
    save_coffee(socket, socket.assigns.action, coffee_params)
  end

  defp save_coffee(socket, :edit, coffee_params) do
    case Inventory.update_coffee(socket.assigns.coffee, coffee_params) do
      {:ok, coffee} ->
        notify_parent({:saved, coffee})

        {:noreply,
         socket
         |> put_flash(:info, "Coffee updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_coffee(socket, :new, coffee_params) do
    case Inventory.create_coffee(coffee_params) do
      {:ok, coffee} ->
        notify_parent({:saved, coffee})

        {:noreply,
         socket
         |> put_flash(:info, "Coffee created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
