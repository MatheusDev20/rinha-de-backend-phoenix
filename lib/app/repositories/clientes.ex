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
    Repo.get(Cliente, id)
  end


  def update_balance(%{client: client, transaction: transaction}) do
    t = Map.get(transaction, "tipo")
    case t do
      "d" ->  IO.inspect('AHA')
      "c" ->   Repo.update!(Cliente.changeset(client, %{saldo_inicial: client.saldo_inicial + transaction["valor"]}))
    end
  end

end
