defmodule MathiasCoffeeWeb.PageLive do
  use MathiasCoffeeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Page</hjson>
    """
  end
end