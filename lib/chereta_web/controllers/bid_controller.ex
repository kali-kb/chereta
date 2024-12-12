defmodule CheretaWeb.BidController do
  use CheretaWeb, :controller
  alias Chereta.Context.Bid

  def index(conn, %{"item_id" => item_id}) do
    bids = Bid.list_item_bids(item_id)
    render(conn, :index, bids: bids)
  end

  def create(conn, %{"user_id" => user_id, "item_id" => item_id, "bid" => bid_params}) do
    user_id = String.to_integer(user_id)
    item_id = String.to_integer(item_id)
    bid_params_with_ids = Map.merge(bid_params, %{"user_id" => user_id, "item_id" => item_id})
    IO.inspect(bid_params_with_ids)
    with {:ok, bid} <- Bid.create_bid(bid_params_with_ids),
         bid = Chereta.Repo.preload(bid, :user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/bids/#{bid}")
      # |> send_resp(:created, "")
      |> render(:show, bid: bid)
    end
  end
end
