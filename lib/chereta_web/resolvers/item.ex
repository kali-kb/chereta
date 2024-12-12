defmodule CheretaWeb.Resolvers.Item do
  alias Chereta.Context.Item

  def list_items(_parent, %{id: id}, _resolution) do
    IO.inspect("id:" <> id)
    {:ok, Item.list_items(id)}
  end

end
