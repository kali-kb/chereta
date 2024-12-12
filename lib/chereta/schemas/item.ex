defmodule Chereta.Schemas.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:item_id, :id, autogenerate: true}
  schema "items" do
    field :description, :string
    field :title, :string
    field :user_id, :integer, references: :users
    # field :category_id, :integer, references: :categories
    field :image_url, :string
    field :starting_bid, :integer
    field :auction_end, :utc_datetime
    has_many :bids, Chereta.Schemas.Bid, foreign_key: :item_id
    belongs_to :category, Chereta.Schemas.Category, foreign_key: :category_id, references: :category_id
    # belongs_to :user, Chereta.Schemas.User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:item_id, :user_id, :category_id, :title, :description, :image_url, :starting_bid, :auction_end])
    |> validate_required([:user_id, :category_id, :title, :auction_end, :starting_bid])
  end
end
