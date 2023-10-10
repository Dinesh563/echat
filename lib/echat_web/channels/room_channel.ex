defmodule EchatWeb.RoomChannel do
  use EchatWeb, :channel

  @impl true
  def join("rooms:lobby", %{"user_id" => user_id}, socket) do
    {:ok, socket |> assign(:user_id, user_id)}
  end

  @impl true
  def handle_in("new_user", payload, socket) do
    broadcast(socket, "user_entered", %{user_id: socket.assigns.user_id})
    {:noreply, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast(socket, "display_message", payload)
    {:noreply, socket}
  end
end
