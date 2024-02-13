defmodule App.Repo.Migrations.CreateTransacoesTable do
  use Ecto.Migration

  def change do
    create table(:transacoes) do
      add :valor, :integer
      add :tipo, :string
      add :descricao, :string
      add :cliente_id, references(:clientes, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
