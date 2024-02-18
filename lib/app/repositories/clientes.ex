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


  def update_balance(value) do
    Repo.update!(Cliente, set: [limite: value])
  end

end
