defmodule App.Transacoes.Transacao do

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "transacoes" do
    field :valor, :integer
    field :tipo, Ecto.Enum, values: [:c, :d]
    field :descricao, :string
    belongs_to :cliente, App.Clientes.Cliente

    timestamps inserted_at: :realizada_em,
    updated_at: false,
    type: :utc_datetime_usec
  end

  # Estrutura de registro que representa uma modificação
   def changeset(doc \\ %Transacao{} , %{} = alteracoes) do
    doc
    |> cast(alteracoes, [:cliente_id, :valor, :tipo, :descricao])
    |> validate_required([:valor, :tipo, :descricao, :cliente_id])
    |> validate_inclusion(:tipo, [:c, :d])
    |> validate_length(:descricao, min: 1, max: 10)
  end

  def generate(%{} = params) do
    params
    |> changeset()
    |> apply_action(:new)
  end
end
