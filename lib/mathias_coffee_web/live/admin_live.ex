defmodule MathiasCoffeeWeb.AdminLive do
  use MathiasCoffeeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h1>Admin</h1>
      <p>Admin page</p>
    </div>
    """
  end
end
