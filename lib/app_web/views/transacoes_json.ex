defmodule AppWeb.TransacoesJSON do

  alias App.TransacoesRepository

  def index(%{transacoes: transacoes}) do
    transacoes
  end

  def create(%{data: transacao}) do
    TransacoesRepository.insert(%{transaction: transacao})
    res = %{status: "ok", message: "Transacao criada com sucesso"}
    %{data: res}
  end
end
