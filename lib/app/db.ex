defmodule App.DB do

  alias App.Clientes.Cliente
  alias App.Repo
  alias App.Transacoes.Transacao
  alias Ecto.Multi

  def persistir_transacao(%Transacao{} = transacao) do
    novo_saldo = calcula_variacao(transacao.tipo, transacao.valor)
    executa_transacao(transacao, novo_saldo)
  end

  # Ver se é possível otimizar e não fazer duas consultas.
  defp executa_transacao(%Transacao{} = transacao, delta) do
    cliente = Repo.get(Cliente, transacao.cliente_id)
    case cliente do
      nil -> {:error, :not_found}
      _ ->
        novo_saldo = cliente.saldo + delta
        cond do
          novo_saldo < (cliente.limite * -1) -> {:error, :unprocessable_entity}
          true ->
          db_transacao =
              Ecto.Multi.new()
              |> Multi.insert(:transacao, transacao)
              |> Multi.update(:update_saldo, Cliente.changeset(cliente, %{saldo: novo_saldo}))
              case Repo.transaction(db_transacao) do
                  {:ok, %{ update_saldo: db_resposta }} -> {:ok,  %{saldo: db_resposta.saldo, limite: db_resposta.limite}}
                  {:error, _} -> {:error, "DB Transaction failed"}
               end
        end
    end
  end

  defp calcula_variacao(:c, valor_transacao) do valor_transacao end
  defp calcula_variacao(:d, valor_transacao) do valor_transacao * -1 end

  defp get_last_transactions(id) do

    Repo.query('WITH ClientInfo AS ( SELECT id, saldo, limite FROM clientes WHERE id = #{id})
    SELECT ci.limite, ci.saldo, t.valor, t.tipo, t.descricao, t.realizada_em
    FROM ClientInfo ci
    LEFT JOIN transacoes t ON ci.id = t.cliente_id
    WHERE ci.id = #{id}
    ORDER BY t.realizada_em DESC LIMIT 10;')
  end

  def show_client_extract(cliente_id) do
    get_last_transactions(cliente_id) |> build_extract()
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
