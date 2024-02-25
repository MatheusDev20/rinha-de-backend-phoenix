defmodule AppWeb.TransacoesController do
  use AppWeb, :controller

  def create(conn, params) do
    render(conn, :create, %{ data: params })
  end
end
