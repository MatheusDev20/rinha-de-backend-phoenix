defmodule AppWeb.MainJSON do

  def transacao_response(%{data: response}) do
    response
  end

  def show_extract(%{extract: data}) do
    data
  end
end
