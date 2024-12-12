defmodule CheretaWeb.ItemController do
  use CheretaWeb, :controller
  alias Chereta.Context.Item

  def index(conn, _params) do
    items = Item.list_items()
    IO.inspect(items, lable: "items with association")
    render(conn, :index, items: items)
  end

  def show(conn, %{"item_id" => id}) do
    item = Item.get_item(id)
    IO.inspect(item, label: "item with association")
    render(conn, :show, item: item)
  end

  def create(conn, params) do
    %{"user_id" => user_id, "item" => item_params} = params
    IO.inspect(user_id, label: "user id")
    IO.inspect(item_params, label: "item params")
    with {:ok, item} <- Item.create_item(Map.put(item_params, "user_id", user_id)) do
      conn
      |> put_status(:created)
      |> assign(:item_id, item.item_id)
      |> send_resp(:created, "")
    end
  end


  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Item.get_item(id)
    with {:ok, item} <- Item.update_item(item, item_params) do
      render(conn, :show, item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Item.get_item(id)
    with {:ok, item} <- Item.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end

end
