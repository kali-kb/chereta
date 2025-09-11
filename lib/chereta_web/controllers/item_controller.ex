defmodule CheretaWeb.ItemController do
  use CheretaWeb, :controller
  alias Chereta.Context.Item

  def index(conn, _params) do
    items = Item.list_items()
    IO.inspect(items, label: "items with association")
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

    case Item.create_item(Map.put(item_params, "user_id", user_id)) do
      {:ok, item} ->
        conn
        |> put_status(:created)
        |> assign(:item_id, item.item_id)
        |> send_resp(:created, "")

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: format_changeset_errors(changeset)})
    end
  end

  defp format_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
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
