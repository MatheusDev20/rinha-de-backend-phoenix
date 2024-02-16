defmodule AppWeb.ClientesController do

  use AppWeb, :controller
  alias App.ClientesRepository
  # alias App.Clientes.Cliente

  def index(conn, _params) do
    clientes = ClientesRepository.list_clientes()
    render(conn, :index, clientes: clientes)
  end
end
