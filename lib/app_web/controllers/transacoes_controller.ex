defmodule AppWeb.TransacoesController do
  alias App.Transacoes
  use AppWeb, :controller

  def index(conn, _params) do
    transacoes = Transacoes.listar_transacoes()
    render(conn, :index, transacoes: transacoes)
  end

end
