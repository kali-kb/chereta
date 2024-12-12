defmodule Chereta.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :item_id, :bigserial, primary_key: true
      add :category_id, references(:categories, column: :category_id, type: :serial), null: false
      add :user_id, references(:users, column: :user_id, type: :bigserial), null: false
      add :title, :string
      add :description, :text
      add :image_url, :text
      add :starting_bid, :integer
      add :auction_end, :utc_datetime
      timestamps(type: :utc_datetime)
    end
  end
end
