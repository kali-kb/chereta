defmodule Chereta.Context.Bid do
  alias Chereta.Schemas.Bid
  alias Chereta.Repo
  import Ecto.Query

  def list_bids do
    Repo.all(Bid)
  end

  def list_item_bids(item_id) do
    query = from b in Bid,
    where: b.item_id == ^item_id,
    order_by: [desc: b.bid_time]
    Repo.all(query)
  end

  def get_bid(bid_id) do
    bids = Repo.get(Bid, bid_id) |> Repo.preload(:user)
    IO.inspect(bids)
    bids
  end


  def delete_bid(bid_id) do
    bid = get_bid(bid_id)
    Repo.delete(bid)
  end

  def create_bid(attrs \\ %{}) do
    %Bid{}
    |> Bid.changeset(attrs)
    |> Repo.insert()
  end

end
