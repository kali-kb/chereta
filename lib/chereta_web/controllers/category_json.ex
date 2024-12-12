defmodule CheretaWeb.CategoryJSON do
  alias Chereta.Schemas.Category

  @doc """
  Renders a list of categories.
  """
  def index(%{categories: categories}) do
    %{data: for(category <- categories, do: data(category))}
  end

  @doc """
  Renders a single category.
  """
  def show(%{category: category}) do
    %{data: data(category)}
  end

  defp data(%Category{} = category) do
    %{
      id: category.category_id,
      name: category.name,
      description: category.description,
      inserted_at: category.inserted_at,
      updated_at: category.updated_at,
      items: %{
        data: for(item <- category.items, do: %{
          item_id: item.item_id,
          title: item.title,
          description: item.description,
          starting_bid: item.starting_bid,
          img_url: item.image_url,
          inserted_at: item.inserted_at,
          updated_at: item.updated_at,

          bids: %{data: for(bid <- item.bids, do: %{
            bid_id: bid.bid_id,
          })}


        })
      }
    }
  end
end
