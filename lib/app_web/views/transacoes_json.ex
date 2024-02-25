defmodule AppWeb.TransacoesJSON do

  def index(%{transacoes: transacoes}) do
    transacoes
  end

  def show(%{transaction: data}) do
    data
  end
end
