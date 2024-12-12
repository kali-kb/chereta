defmodule CheretaWeb.Schema do
  use Absinthe.Schema

  import_types(CheretaWeb.Schema.ItemTypes)
  # import_types(CheretaWeb.Schema.UserTypes)
  # import_types(CheretaWeb.Schema.BidTypes)

  alias CheretaWeb.Resolvers

  query do
    @desc "get all items"
    field :items, list_of(:item) do
      arg :id, :id
      # arg :id, non_null(:id)
      # arg :min_bid, :integer
      # arg :title, :string
      resolve(&Resolvers.Item.list_items/3)
    end
  end
end
