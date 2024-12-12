defmodule Chereta.Schemas.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  # @secret "HashSecret"

  @primary_key {:user_id, :id, autogenerate: true}
  schema "users" do
    # field :integer, primary_key: true
    field :name, :string
    field :email, :string
    field :password_hash, :string
    has_many :bids, Chereta.Schemas.Bid, foreign_key: :user_id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
    |> hash_password()
  end


  defp hash_password(changeset) do
    pwd = get_field(changeset, :password_hash)
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pwd))
  end

end
