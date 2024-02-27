defmodule App.ClientesRepository do

  @moduledoc """
  The Clientes context.
  """
  import Ecto.Query, warn: false

  alias App.Clientes.Cliente
  alias App.Repo

  def list_clientes do
    Repo.all(Cliente)
  end

  def list_by_id(id) do
    client = Repo.get(Cliente, id)
    case client do
      nil -> {:error, :not_found}
      client -> client
    end
  end

  def get_by_id(id, assoc \\ false) do
    cond do
      assoc -> Repo.get(Cliente, id) |> Repo.preload(:transacoes)
      true -> Repo.get(Cliente, id)
    end
  end

  def update_balance(%{client: client, transaction: transaction}) do
    calculate_new_balance(Map.get(transaction, "tipo"), client, Map.get(transaction, "valor"))
  end

  defp calculate_new_balance("c", client, new_transaction_value) do
    new_balance = client.saldo + new_transaction_value
    Repo.update!(Cliente.changeset(client, %{saldo: new_balance}))
    %{limite: client.limite, saldo: new_balance}
  end

  defp calculate_new_balance("d", client, new_transaction_value) do
    new_balance = client.saldo - new_transaction_value
    cond do
      new_balance < (client.limite * -1 ) -> %{ error: "Transaction would exceed the client's limit"}
      true ->
        Repo.update!(Cliente.changeset(client, %{saldo: new_balance}))
        %{limite: client.limite, saldo: new_balance}
    end
  end
end
