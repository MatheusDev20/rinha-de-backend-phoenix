defmodule AppWeb.TransacoesJSON do

  def index(%{transacoes: transacoes}) do
    transacoes
  end

  def create(%{message: message}) do
    %{message: message}
  end
end
