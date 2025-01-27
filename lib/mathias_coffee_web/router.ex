defmodule MathiasCoffeeWeb.Router do
  use MathiasCoffeeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MathiasCoffeeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug MathiasCoffeeWeb.Plugs.BasicAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :shopping_cart,
    on_mount: [MathiasCoffeeWeb.Nav] do
    scope "/", MathiasCoffeeWeb do
      pipe_through :browser

      live "/", PageLive
      live "/checkout", CheckoutLive
    end
  end

  live_session :admin, layout: {MathiasCoffeeWeb.Layouts, :admin} do
    scope("/admin", MathiasCoffeeWeb) do
      pipe_through [:browser, :admin]

      live "/", CoffeeLive.Index, :index

      live "/coffees/new", CoffeeLive.Index, :new
      live "/coffees/:id/edit", CoffeeLive.Index, :edit

      live "/coffees/:id", CoffeeLive.Show, :show
      live "/coffees/:id/show/edit", CoffeeLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", MathiasCoffeeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mathias_coffee, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MathiasCoffeeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
