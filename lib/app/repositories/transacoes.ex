defmodule App.Transacoes do

  import Ecto.Query, warn: false
  alias App.Transacoes.Transacao
  alias App.Repo

  def listar_transacoes do
    Repo.all(Transacao)
  end

end
