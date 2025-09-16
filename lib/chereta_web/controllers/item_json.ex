defmodule CheretaWeb.ItemJSON do
  alias Chereta.Schemas.Item

  def index(%{items: items}) do
    %{data: for(item <- items, do: data(item))}
  end

  def show(%{item: item}) do
    %{data: data(item)}
  end

  defp data(%Item{} = item) do
    %{
      item_id: item.item_id,
      title: item.title,
      description: item.description,
      user_id: item.user_id,
      category: %{
        category_id: item.category.category_id,
        name: item.category.name
      },
      img_url: item.image_url,
      starting_bid: item.starting_bid,
      auction_end: item.auction_end,
      created_at: item.inserted_at,
      updated_at: item.updated_at,
      bids:  item.bids
      |> Enum.sort_by(&(&1.bid_amount), :desc)
      |> Enum.map(fn bid ->
        %{
          bid_id: bid.bid_id,
          bid_amount: bid.bid_amount,
          inserted_at: bid.inserted_at,
          user: %{
            user_id: bid.user.user_id,
            name: bid.user.name,
            email: bid.user.email,
            phone: bid.user.phone
          }
        }
      end)
    }
  end

end
