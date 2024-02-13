defmodule App.Transacoes do

  import Ecto.Query, warn: false
  alias App.Repo

  def listar_transacoes do
    Repo.query_many("SELECT * FROM transacoes", [])
  end

end
