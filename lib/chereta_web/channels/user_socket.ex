defmodule CheretaWeb.UserSocket do
  use Phoenix.Socket
  alias Chereta.Guardian
  # A Socket handler
  #
  # It's possible to control the websocket connection and
  # assign values that can be accessed by your channel topics.

  ## Channels
  # Uncomment the following line to define a "room:*" topic
  # pointing to the `CheretaWeb.RoomChannel`:
  #
  channel "item:*", CheretaWeb.ItemChannel
  #
  # To create a channel file, use the mix task:
  #
  #     mix phx.gen.channel Room
  #
  # See the [`Channels guide`](https://hexdocs.pm/phoenix/channels.html)
  # for further details.


  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error` or `{:error, term}`. To control the
  # response the client receives in that case, [define an error handler in the
  # websocket
  # configuration](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#socket/3-websocket-configuration).
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(params, socket, _connect_info) do
    IO.inspect("Socket connect params: #{inspect(params)}")
    case authenticate_user(params["token"]) do
      {:ok, user} ->
        IO.inspect("User authenticated: #{inspect(user)}")
        {:ok, assign(socket, :user, user)}
      {:error, reason} ->
        IO.inspect("Authentication failed: #{inspect(reason)}, allowing anonymous connection")
        # Allow anonymous connection for read-only access
        {:ok, assign(socket, :user, nil)}
    end
  end

  # Socket IDs are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Elixir.CheretaWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.

  defp authenticate_user(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        Guardian.resource_from_claims(claims)
      {:error, _reason} ->
        {:error, :unauthorized}
    end
  end


  @impl true
  def id(_socket), do: nil
end
