defmodule AppWeb.TransacoesController do
  use AppWeb, :controller
  alias App.TransacoesRepository

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, response} <- TransacoesRepository.create(%{transaction: params}) do
      render(conn, :show, %{ transaction: response })
    end
  end

end
