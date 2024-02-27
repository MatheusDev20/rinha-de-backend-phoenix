defmodule AppWeb.Router do
  # alias AppWeb.UrlController
  # alias App.ClientesController
  use AppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppWeb do
    pipe_through :api
    resources "/clientes", ClientesController, except: [:new, :edit]
    post "/clientes/:id/transacoes", TransacoesController, :create
    get "/clientes/:id/extrato", TransacoesController, :show_extract
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
    end
  end
end
