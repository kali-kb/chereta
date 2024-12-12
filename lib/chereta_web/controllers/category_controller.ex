defmodule CheretaWeb.CategoryController do
  use CheretaWeb, :controller
  alias Chereta.Schemas.Category
  alias Chereta.Context.Category

  #the "category" parameter is the name of the JSON field in the request body
  #so it expect the JSON structure to be like this: {"category": {"name": "string", "description": "string"}}

  def index(conn, _params) do
    categories = Category.list_categories()
    render(conn, :index, categories: categories)
  end

  def show(conn, _params) do
    category = Category.get_category(conn.params["id"])
    conn |> put_status(:ok) |> render(:show, category: category)
  end

  def create(conn, %{"category" => category_params}) do

    with {:ok, category} <- Category.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/categories/#{category}")
      |> send_resp(:created, "")
    end
  end

end
