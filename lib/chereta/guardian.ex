defmodule Chereta.Guardian do
  use Guardian, otp_app: :chereta
  alias Chereta.Schemas.Accounts.User
  alias Chereta.Repo

  def subject_for_token(user, _claims) do
    sub = to_string(user.user_id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = User |> Repo.get(id)
    {:ok, resource}
  end

  def build_claims(claims, user, _opts) do
    {:ok, Map.put(claims, "name", user.name)}
  end


end
