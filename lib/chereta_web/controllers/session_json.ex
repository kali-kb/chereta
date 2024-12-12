defmodule CheretaWeb.SessionJSON do
  alias Chereta.Schemas.Accounts.User

  def create(%{user: user, token: token}) do
    %{
      data: %{
        id: user.user_id,
        email: user.email,
        name: user.name,
        token: token
      }
    }
  end

  def error(%{message: message}) do
    %{
      error: message
    }
  end
end
