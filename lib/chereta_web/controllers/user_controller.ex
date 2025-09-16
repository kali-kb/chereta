defmodule CheretaWeb.UserController do
  use CheretaWeb, :controller
  alias Chereta.Context.User
  alias CheretaWeb.UserJSON
  alias Chereta.Guardian

  # action_fallback CheretaWeb.FallbackController

  # plug CheretaWeb.Plugs.RequireAuth when action in [:show]

  def index(conn, _params) do
    users = User.list_users()
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => user_id}) do
    user = User.get_user(user_id)
    render(conn, :show, user: user)
  end

  def create(conn, %{"user" => user_params}) do
    # IO.inspect(user_params)
    user_params = %{
      "name" => user_params["name"],
      "email" => user_params["email"],
      "phone" => user_params["phone"],
      "password_hash" => user_params["password"]
    }
    with {:ok, user} <- User.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user)  do
      conn
      |> put_status(:created)
      |> assign(:user_id, user.user_id)
      |> render(:create, user: user, token: token)
    end
  end
end
