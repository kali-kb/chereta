defmodule Chereta.Repo do
  use Ecto.Repo,
    otp_app: :chereta,
    adapter: Ecto.Adapters.Postgres
end
