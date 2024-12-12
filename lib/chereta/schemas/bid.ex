defmodule Chereta.Schemas.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:bid_id, :item_id, :user_id, :bid_amount, :bid_time, :inserted_at]}

  @primary_key {:bid_id, :id, autogenerate: true}
  schema "bids" do
    belongs_to :item, Chereta.Schemas.Item, foreign_key: :item_id
    belongs_to :user, Chereta.Schemas.Accounts.User, foreign_key: :user_id, references: :user_id
    field :bid_amount, :integer
    field :bid_time, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:item_id, :user_id, :bid_amount])
    |> validate_required([:item_id, :user_id, :bid_amount])
  end
end
