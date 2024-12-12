defmodule CheretaWeb.SessionController do
  use CheretaWeb, :controller
  alias Chereta.Context.User
  alias Chereta.Guardian
  alias CheretaWeb.Controllers.SessionJSON


  def create(conn, %{"user" => user_params}) do
    case User.get_and_auth_user(user_params) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        conn
        |> put_status(:created)
        |> render(:create, user: user, token: token)
      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, message: message)
    end
  end
end
