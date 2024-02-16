defmodule AppWeb.TransacoesController do
  alias App.Transacoes
  use AppWeb, :controller


  def index(conn, _params) do
    transacoes = Transacoes.listar_transacoes()
    # This function will look for a template by the module name and an action "index" and render with the given assigns (transacoes: transacoes)
    render(conn, :index, transacoes: transacoes)
  end


  def create(conn, params) do
    render(conn, :create, %{data: params})
  end

end
