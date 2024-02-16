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

end