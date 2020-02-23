defmodule LiveViewChatWeb.ChatLive.Chat do
  use Phoenix.LiveView
  alias LiveViewChat.Chat
  alias LiveViewChat.Chat.ChatPost
  alias LiveViewChatWeb.ChatView
  alias LiveViewChatWeb.Presence
  @topic "chat"

  def mount(_params, _session, socket) do
    user = "User-"<>Chat.random_string(4)

    if connected?(socket) do
      # Subscribe to Presence.
      Presence.track(self(), @topic, user, %{online_at: inspect(System.system_time(:second))})

      # Subscribe to PubSub.
      LiveViewChatWeb.Endpoint.subscribe(@topic)
    end

    changeset = Chat.change_chat_post(%ChatPost{})
    socket = assign(socket, changeset: changeset, chat_posts: [], user: user, number_of_users: number_of_users())
    {:ok, socket, temporary_assigns: [chat_posts: []]}
  end

  def render(assigns) do
    ChatView.render("chat.html", assigns)
  end

  # Event handler for Live View
  def handle_event("create", %{"chat_post" => chat_post}, socket) do
    id = Chat.random_string(12)
    chat_post = Map.replace!(chat_post, "chat_post", "#{chat_post["user"]}: #{chat_post["chat_post"]}")

    LiveViewChatWeb.Endpoint.broadcast_from(self(), @topic, "create", %{chat_post: chat_post, id: id})

    {:noreply, assign(socket, chat_posts: [chat_post], id: id)}
  end

  # Handler for Presence.
  def handle_info(%{event: "presence_diff", payload: _payload} = _info, socket) do
    {:noreply, assign(socket, number_of_users: number_of_users())}
  end

  # Handler for PubSub broadcast_from.
  def handle_info(%{topic: @topic, payload: %{chat_post: chat_post, id: id}}, socket) do
    {:noreply, assign(socket, chat_posts: [chat_post], id: id)}
  end

  # Returns the number of user assigned to a topic.
  defp number_of_users() do
    Presence.list(@topic)
    |> Map.keys()
    |> length()
  end

end