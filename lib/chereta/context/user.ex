defmodule Chereta.Context.User do
  alias Chereta.Repo
  alias Chereta.Schemas.Accounts.User


  def list_users, do: Repo.all(User)

  def get_user(user_id), do: Repo.get(User, user_id)

  def get_and_auth_user(user_params) do
    user = Repo.get_by(User, email: user_params["email"])
    IO.inspect(user)
    case user do
      nil -> {:error, "User not found"}
      user ->
        case Bcrypt.verify_pass(user_params["password"], user.password_hash) do
          true -> {:ok, user}
          false -> {:error, "Invalid email or password"}
        end

      end
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(user), do: Repo.delete(user)


end
