defmodule App.Clientes.Cliente do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clientes" do
    field :nome, :string
    field :limite, :integer
    field :saldo, :integer
    has_many :transacoes, App.Transacoes.Transacao
  end

  @doc false
  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:nome, :limite, :saldo])
    |> validate_required([:nome, :limite, :saldo])
  end
end
