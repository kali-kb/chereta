defmodule Chereta.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories, primary_key: false) do
      add :category_id, :serial, primary_key: true
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
