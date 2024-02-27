defmodule AppWeb.TransacoesJSON do

  def index(%{transacoes: data}) do
    data
  end

  def show(%{transaction: data}) do
    data
  end

  def show_extract(%{extract: data}) do
    data
  end
end
