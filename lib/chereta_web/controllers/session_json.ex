defmodule CheretaWeb.SessionJSON do
  alias Chereta.Schemas.Accounts.User

  def create(%{user: user, token: token}) do
    %{
      user: %{
        id: user.user_id,
        email: user.email,
        name: user.name,
        phone: user.phone
      },
      token: token
    }
  end

  def profile(%{user: user}) do
    %{
      data: %{
        user: %{
          id: user.user_id,
          email: user.email,
          name: user.name,
          phone: user.phone
        }
      }
    }
  end

  def error(%{message: message}) do
    %{
      error: message
    }
  end
end
