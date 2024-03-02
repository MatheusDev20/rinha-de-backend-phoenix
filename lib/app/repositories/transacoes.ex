defmodule App.TransacoesRepository do

  import Ecto.Query, warn: false
  alias App.ClientesRepository
  alias App.Repo

  def create(%{transaction: data }) do
    # 1 Consulta
    client_data = Map.fetch(data, "id") |> elem(1) |> ClientesRepository.get_by_id()
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
      Ecto.build_assoc(client_data, :transacoes, (for {k, v} <-  Map.delete(transaction_data, "id"), into: %{}, do: {String.to_atom(k), v}))
      |>
      Repo.insert!()
      {:ok, balance_response}
  end

  end
