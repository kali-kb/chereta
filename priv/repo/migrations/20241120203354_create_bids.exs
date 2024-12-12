defmodule Chereta.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids, primary_key: false) do
      add :bid_id, :bigserial, primary_key: true
      add :item_id, references(:items, column: :item_id, type: :bigserial), null: false
      add :user_id, references(:users, column: :user_id, type: :bigserial), null: false
      add :bid_amount, :integer
      add :bid_time, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
