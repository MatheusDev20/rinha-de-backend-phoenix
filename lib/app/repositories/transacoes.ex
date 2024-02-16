defmodule App.TransacoesRepository do

  import Ecto.Query, warn: false
  alias App.ClientesRepository
  alias App.Transacoes.Transacao
  alias App.Repo

  def listar_transacoes do
    Repo.all(Transacao)
  end


  def insert(%{transaction: data}) do
    client = ClientesRepository.list_by_id(elem(Map.fetch(data, "id"), 1))
    assoc = Ecto.build_assoc(client, :transacoes, (for {k, v} <-  Map.delete(data, "id"), into: %{}, do: {String.to_atom(k), v}))
    Repo.insert!(assoc)
  end

end
