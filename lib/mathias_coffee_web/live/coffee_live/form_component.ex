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
        <.input field={@form[:price]} type="number" label="Price (kr)" step="any" />
        <.input field={@form[:altitude]} type="number" label="Altitude (meter)" step="any" />
        <div class="flex justify-between">
          <.input
            phx-change="update_taste_note"
            label="Taste Note"
            type="text"
            name="taste_note"
            value={@taste_note}
            phx-target={@myself}
          />
          <div
            class="text-zinc-700 text-xs mt-8 py-3 px-6 border-zinc-600 border rounded-md"
            phx-target={@myself}
            phx-click="add_taste_note"
          >
            Add
          </div>
        </div>

        <div class="flex gap-x-2">
          <%= for taste_note <- @taste_notes do %>
            <div
              phx-target={@myself}
              phx-click="remove_taste_note"
              phx-value-name={taste_note}
              class="py-1 px-2 rounded-md bg-orange-400 text-xs text-zinc-800 flex"
            >
              {taste_note} x
            </div>
          <% end %>
        </div>
        <:actions>
          <.button class="w-full" phx-disable-with="Saving...">Save Coffee</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{coffee: coffee} = assigns, socket) do
    dbg(coffee)
    taste_notes = Enum.map(coffee.taste_notes, & &1.name)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:taste_note, "")
     |> assign(:taste_notes, taste_notes)
     |> assign_new(:form, fn ->
       coffee
       |> Inventory.change_coffee()
       |> to_form()
     end)}
  end

  @impl true
  def handle_event("update_taste_note", %{"taste_note" => taste_note}, socket) do
    {:noreply, assign(socket, taste_note: taste_note)}
  end

  @impl true
  def handle_event("remove_taste_note", %{"name" => name}, socket) do
    taste_notes = Enum.filter(socket.assigns.taste_notes, &(&1 != name))
    {:noreply, assign(socket, taste_notes: taste_notes)}
  end

  @impl true
  def handle_event("add_taste_note", _, socket) do
    taste_notes = socket.assigns.taste_notes ++ [socket.assigns.taste_note]
    {:noreply, assign(socket, taste_notes: taste_notes)}
  end

  @impl true
  def handle_event("validate", %{"coffee" => coffee_params}, socket) do
    changeset = Inventory.change_coffee(socket.assigns.coffee, coffee_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"coffee" => coffee_params}, socket) do
    save_coffee(socket, socket.assigns.action, coffee_params)
  end

  defp save_coffee(socket, :edit, params) do
    coffee_params = Map.put(params, "taste_notes", socket.assigns.taste_notes)

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

  defp save_coffee(socket, :new, params) do
    coffee_params = Map.put(params, "taste_notes", socket.assigns.taste_notes)

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
