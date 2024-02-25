defmodule App.TransacoesRepository do

  import Ecto.Query, warn: false
  alias App.ClientesRepository
  alias App.Repo

  # def listar_transacoes do
  #   Repo.all(Transacao)
  # end


  def insert(%{transaction: data}) do
    client_data = ClientesRepository.list_by_id(elem(Map.fetch(data, "id"), 1))
    value = ClientesRepository.update_balance(%{client: client_data, transaction: data})

    case value do
      %{error: message} -> %{ error: message, status: 422 }
      %{saldo: v, limite: l} ->
        assoc = Ecto.build_assoc(client_data, :transacoes, (for {k, v} <-  Map.delete(data, "id"), into: %{}, do: {String.to_atom(k), v}))
        Repo.insert!(assoc)
        %{ saldo: v, limite: l}
    end
  end
end
