defmodule LiveViewChatWeb.ChatLive.Chat do
  use Phoenix.LiveView
  alias LiveViewChat.Chat
  alias LiveViewChat.Chat.ChatPost
  alias LiveViewChatWeb.ChatView
  alias LiveViewChatWeb.Presence
  @topic "chat"

  def mount(_params, _session, socket) do
    Presence.track(self(), @topic, "user", %{online_at: inspect(System.system_time(:second))})
    LiveViewChatWeb.Endpoint.subscribe(@topic)
    changeset = Chat.change_chat_post(%ChatPost{})
    socket = assign(socket, changeset: changeset, chat_posts: [], number_of_users: Chat.number_of_users(@topic))
   {:ok, socket, temporary_assigns: [chat_posts: []]}
  end

  def render(assigns) do
    ChatView.render("chat.html", assigns)
  end

  def handle_event("create", %{"chat_post" => chat_post}, socket) do
    id = Chat.random_string()
    LiveViewChatWeb.Endpoint.broadcast_from(self(), @topic, "create", %{chat_post: chat_post, id: id})
    {:noreply, assign(socket, chat_posts: [chat_post], id: id)}
  end

  def handle_info(%{event: "presence_diff", payload: _payload}, socket) do
    {:noreply, assign(socket, number_of_users: Chat.number_of_users(@topic))}
  end

  def handle_info(%{topic: "chat", payload: %{chat_post: chat_post, id: id}}, socket) do
    {:noreply, assign(socket, chat_posts: [chat_post], id: id)}
  end

end