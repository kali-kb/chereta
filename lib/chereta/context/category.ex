defmodule Chereta.Context.Category do
  alias Chereta.Schemas.Category
  alias Chereta.Repo

  def list_categories do
    categories = Repo.all(Category) |> Repo.preload(items: [:bids])
    IO.inspect(categories)
    categories
  end

  def get_category(category_id), do: Repo.get(Category, category_id) |> Repo.preload(items: [:bids])

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

end
