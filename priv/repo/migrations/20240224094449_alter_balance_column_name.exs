defmodule App.Repo.Migrations.AlterBalanceColumnName do
  use Ecto.Migration

  def change do
    rename table(:clientes), :saldo_inicial, to: :saldo
  end
end
