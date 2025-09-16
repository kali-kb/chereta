defmodule CheretaWeb.ItemChannel do
  use CheretaWeb, :channel
  alias CheretaWeb.Presence

  @impl true
  def join("item:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("item:" <> item_id, payload, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, item_id: item_id)}
  end

  @impl true
  def handle_info(:after_join, socket) do
    case socket.assigns[:user] do
      nil ->
        # User is not authenticated, skip presence tracking
        IO.puts("User not authenticated for channel join")
        {:noreply, socket}
      user ->
        # User is authenticated, track presence
        {:ok, _} = Presence.track(socket, user.user_id, %{
          user_name: user.name,
          online_at: inspect(System.system_time(:second))
        })
        push(socket, "presence_state", Presence.list(socket))
        {:noreply, socket}
    end
  end
  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("new_bid", payload, socket) do
    broadcast(socket, "new_bid", payload)
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (item:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
