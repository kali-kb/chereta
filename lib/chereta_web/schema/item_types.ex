defmodule CheretaWeb.Schema.ItemTypes do
  use Absinthe.Schema.Notation
  alias Chereta.Context.Item

  object :item do
    field :item_id, :id
    field :title, :string
    field :description, :string
    field :image_url, :string
    field :starting_bid, :integer
    field :created_at, :string
    field :updated_at, :string
  end
end
