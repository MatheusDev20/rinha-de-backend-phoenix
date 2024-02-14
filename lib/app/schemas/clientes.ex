defmodule App.Clientes.Cliente do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clientes" do
    field :nome, :string
    field :limite, :integer
    field :saldo_inicial, :integer
    has_many :transacoes, App.Transacoes.Transacao

    # Generates inserted_at and updated_at columns
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:nome, :limite, :saldo_inicial])
    |> validate_required([:nome, :limite, :saldo_inicial])
  end
end
