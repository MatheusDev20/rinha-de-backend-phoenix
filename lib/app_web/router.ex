defmodule AppWeb.Router do
  # alias AppWeb.UrlController
  # alias App.ClientesController
  use AppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppWeb do
    pipe_through :api

    scope "/clientes/:cliente_id" do
      post "/transacoes", MainController, :cria_transacao
      get "/extrato", MainController, :cria_extrato
    end
  end
end
