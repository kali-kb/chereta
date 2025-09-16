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

  def profile(conn, _params) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Guardian.decode_and_verify(token) do
          {:ok, claims} ->
            case Guardian.resource_from_claims(claims) do
              {:ok, user} ->
                conn
                |> put_status(:ok)
                |> render(:profile, user: user)
              {:error, _reason} ->
                conn
                |> put_status(:unauthorized)
                |> render(:error, message: "Invalid token")
            end
          {:error, _reason} ->
            conn
            |> put_status(:unauthorized)
            |> render(:error, message: "Invalid token")
        end
      _ ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, message: "Authorization header required")
    end
  end
end
