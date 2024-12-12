defmodule CheretaWeb.BidJSON do
  alias Chereta.Schemas.Bid

  def index(%{bids: bids}) do
    %{data: for(bid <- bids, do: data(bid))}
  end

  def show(%{bid: bid}) do
    %{data: data(bid)}
  end

  defp data(%Bid{} = bid) do
    %{
      id: bid.bid_id,
      item_id: bid.item_id,
      user: %{
        name: bid.user.name,
      },
      user_id: bid.user_id,
      bid_amount: bid.bid_amount,
      bid_time: bid.inserted_at
    }
  end
end
