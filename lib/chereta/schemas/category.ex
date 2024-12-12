defmodule Chereta.Schemas.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:category_id, :id, autogenerate: true}
  schema "categories" do
    field :name, :string
    field :description, :string
    has_many :items, Chereta.Schemas.Item, foreign_key: :category_id
    timestamps(type: :utc_datetime)
  end
  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
