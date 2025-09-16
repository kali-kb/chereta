defmodule CheretaWeb.HealthController do
  use CheretaWeb, :controller

  def check(conn, _params) do
    # Check database connection
    try do
      Chereta.Repo.query!("SELECT 1")
      
      conn
      |> put_status(:ok)
      |> json(%{
        status: "ok",
        timestamp: DateTime.utc_now(),
        service: "chereta-api",
        database: "connected",
        version: Application.spec(:chereta, :vsn) |> to_string()
      })
    rescue
      _ ->
        conn
        |> put_status(:service_unavailable)
        |> json(%{
          status: "error",
          timestamp: DateTime.utc_now(),
          service: "chereta-api",
          database: "disconnected"
        })
    end
  end
end