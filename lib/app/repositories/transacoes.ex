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
    # Update the clientes balance based on the transaction type
    t = Map.get(data, "tipo")
    IO.inspect(t)
    case t do
      "d" -> IO.inspect('Débito')
      # "c" -> ClientesRepository.update_balance(data['valor'] + client['limite'])
      "c" -> IO.inspect('Crédito')
    end

    assoc = Ecto.build_assoc(client, :transacoes, (for {k, v} <-  Map.delete(data, "id"), into: %{}, do: {String.to_atom(k), v}))
    Repo.insert!(assoc)
  end

end
