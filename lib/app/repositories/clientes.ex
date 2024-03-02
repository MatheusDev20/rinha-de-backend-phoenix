defmodule App.ClientesRepository do

  @moduledoc """
  The Clientes context.
  """
  import Ecto.Query, warn: false

  alias App.Clientes.Cliente
  alias App.Repo


  def list_by_id(id) do
    client = Repo.get(Cliente, id)
    case client do
      nil -> {:error, :not_found}
      client -> client
    end
  end

  def get_by_id(id, assoc \\ false) do
    IO.inspect(id)
    IO.inspect(Repo.get(Cliente, id))
    cond do
      assoc -> Repo.get(Cliente, id) |> Repo.preload(:transacoes)
      true -> Repo.get(Cliente, id)
    end
  end

  def update_balance(%{client: client, transaction: transaction}) do
    calculate_new_balance(Map.get(transaction, "tipo"), client, Map.get(transaction, "valor"))
  end

  # Calculate the new balance based on the transaction type
  defp calculate_new_balance("c", client, new_transaction_value) do
    new_balance = client.saldo + new_transaction_value
    # 1 Upate
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

  defp get_last_transactions(id) do
    Repo.query('WITH ClientInfo AS ( SELECT id, saldo, limite FROM clientes WHERE id = #{id})
    SELECT ci.limite, ci.saldo, t.valor, t.tipo, t.descricao, t.realizada_em
    FROM ClientInfo ci
    LEFT JOIN transacoes t ON ci.id = t.cliente_id
    WHERE ci.id = #{id}
    ORDER BY t.realizada_em DESC LIMIT 10;')

  end

  def show_client_extract(%{id: id}) do
    # load assoc
    get_last_transactions(id) |> build_extract()
  end

  defp build_extract(db_result) do
    {_, db_data} = db_result
    [saldo, limite | p] = hd(db_data.rows)

    transactions = case p
      do
        [nil, nil, nil, nil] -> []
        _ ->  Enum.map(db_data.rows, &transaction_map/1)
       end

    extract = %{
      saldo: %{
        total: saldo,
        limite: limite,
        data_extract: DateTime.utc_now()
      },
      ultimas_transacoes: transactions
    }

    {:ok, extract}
  end
  defp transaction_map([_, _, valor, tipo, descricao, date]) do
      %{tipo: tipo, valor: valor, descricao: descricao, date: date}
  end

end
