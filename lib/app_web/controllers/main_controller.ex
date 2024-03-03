defmodule AppWeb.MainController do

  use AppWeb, :controller

  action_fallback AppWeb.FallbackController
  import App.Main, only: [cria_transacao: 1, gera_extrato: 1]

  def cria_transacao(conn, params) do
    with {:ok, response} <- cria_transacao(params) do
      render(conn, :transacao_response, %{data: response})
    end
  end

  def cria_extrato(conn, params) do
    with {:ok, response} <- gera_extrato(params) do
      render(conn, :show_extract, %{extract: response})
    end
  end
end
