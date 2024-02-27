defmodule AppWeb.TransacoesController do
  use AppWeb, :controller
  alias App.TransacoesRepository

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, response} <- TransacoesRepository.create(%{transaction: params}) do
      render(conn, :show, %{transaction: response })
    end
  end

  def show_extract(conn, params) do
    id = Map.fetch(params, "id") |> elem(1)
    with {:ok, response} <- TransacoesRepository.show_client_extract(%{id: id}) do
      render(conn, :show_extract, %{extract: response})
    end
  end
end
