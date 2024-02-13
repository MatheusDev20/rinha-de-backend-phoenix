defmodule App.Transacoes.Transacao do

  use Ecto.Schema
  import Ecto.Changeset

  schema "transacoes" do
    field :valor, :integer
    field :tipo, :string
    field :descricao, :string
    belongs_to :cliente, App.Clientes.Cliente

    timestamps(type: :utc_datetime)
  end

   @doc false
   def changeset(transacao, attrs) do
    transacao
    |> cast(attrs, [:valor, :tipo, :descricao])
    |> validate_required([:valor, :tipo, :descricao])
  end


end
