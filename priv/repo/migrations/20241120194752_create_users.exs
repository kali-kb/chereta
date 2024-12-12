defmodule Chereta.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :user_id, :bigserial, primary_key: true
      add :name, :string
      add :email, :string
      add :password_hash, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end
