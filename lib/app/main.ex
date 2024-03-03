defmodule App.Main do

  alias App.DB
  alias App.Transacoes.Transacao


  def cria_transacao(params) do
    with {:ok, transacao_changeset} <- Transacao.generate(params),
    {:ok, resposta} <- DB.persistir_transacao(transacao_changeset) do
        {:ok, resposta}
    end
  end

  def gera_extrato(params) do
    with {:ok, resposta} <- DB.show_client_extract(params["cliente_id"]) do
      {:ok, resposta}
    end
  end
end
