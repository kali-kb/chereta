# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chereta.Repo.insert!(%Chereta.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Create some initial categories
categories = [
  %{name: "Electronics", description: "Electronic devices and gadgets"},
  %{name: "Clothing", description: "Fashion and apparel items"},
  %{name: "Home & Garden", description: "Home improvement and garden supplies"},
  %{name: "Sports", description: "Sports equipment and gear"},
  %{name: "Books", description: "Books and educational materials"},
  %{name: "Toys", description: "Toys and games"},
  %{name: "Automotive", description: "Cars, motorcycles, and automotive parts"},
  %{name: "Art & Collectibles", description: "Artwork, antiques, and collectible items"},
]

Enum.each(categories, fn category_attrs ->
  case Chereta.Repo.get_by(Chereta.Schemas.Category, name: category_attrs.name) do
    nil ->
      %Chereta.Schemas.Category{}
      |> Chereta.Schemas.Category.changeset(category_attrs)
      |> Chereta.Repo.insert!()
    _existing -> :ok
  end
end)
