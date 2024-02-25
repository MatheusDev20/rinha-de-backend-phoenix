defmodule App.TransacoesRepository do

  import Ecto.Query, warn: false
  alias App.ClientesRepository
  alias App.Repo

  def create(%{transaction: data }) do
    client_data = ClientesRepository.list_by_id(elem(Map.fetch(data, "id"), 1))
    case client_data do
      {:error, :not_found} -> {:error, :not_found}
      _->
        response = ClientesRepository.update_balance(%{client: client_data, transaction: data})
        case response do
            %{error: message} -> %{error: message, status: 422}
            %{saldo: _, limite: _} -> insert_transaction(client_data, data, response)
          end
    end
  end

  defp insert_transaction(client_data, transaction_data, balance_response) do
      assoc = Ecto.build_assoc(client_data, :transacoes, (for {k, v} <-  Map.delete(transaction_data, "id"), into: %{}, do: {String.to_atom(k), v}))
      Repo.insert!(assoc)
      balance_response
  end
end
