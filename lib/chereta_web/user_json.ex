defmodule CheretaWeb.UserJSON do
  alias Chereta.Context.User
  alias Chereta.Schemas.Accounts.User

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%{user: user}) do
    %{data: data(user)}
  end

  def create(%{user: user, token: token}) do
    %{
      user: data(user),
      token: token
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.user_id,
      name: user.name,
      email: user.email,
      phone: user.phone
    }
  end
end
