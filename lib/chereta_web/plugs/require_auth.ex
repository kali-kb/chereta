defmodule CheretaWeb.Plugs.RequireAuth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_user_session(conn, :user_id) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.json(%{error: "Unauthorized"})
        |> halt()
      user_id ->
        assign(conn, :current_user, user_id)
    end
  end
  # defp halt(conn), do: conn

  defp get_user_session(conn, key), do: Plug.Conn.get_session(conn, key)

end
