defmodule Chereta.Context.Item do
  alias Chereta.Schemas.Item
  alias Chereta.Repo

  def list_items() do
    data = Repo.all(Item) |> Repo.preload([:category, bids: [:user]])
    IO.inspect(data)
  end

  def get_item(item_id) do
    Repo.get(Item, item_id) |> Repo.preload([:category, bids: [:user]])
  end

  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def delete_item(item_id) do
    item = get_item(item_id)
    Repo.delete(item)
  end

  def update_item(item_id, attrs) do
    item = get_item(item_id)
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

end
