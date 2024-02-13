defmodule AppWeb.ClientesJSON do

  alias App.Clientes.Cliente

  def index(%{clientes: clientes}) do
    %{data: for(cliente <- clientes, do: data(cliente))}
  end

  defp data(%Cliente{} = cliente) do
    %{
      id: cliente.id,
      nome: cliente.nome,
    }
  end
end
