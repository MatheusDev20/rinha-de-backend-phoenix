defmodule AppWeb.ClientsJSON do

  def show(%{transaction: data}) do
    data
  end

  def show_extract(%{extract: data}) do
    data
  end
end
