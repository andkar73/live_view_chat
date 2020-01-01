defmodule LiveViewChatWeb.ChatLive.Chat do
  use Phoenix.LiveView
  alias LiveViewChat.Chat
  alias LiveViewChat.Chat.ChatPost
  alias LiveViewChatWeb.ChatView
  @topic "chat"

  def mount(_session, socket) do
    LiveViewChatWeb.Endpoint.subscribe(@topic)
    changeset = Chat.change_chat_post(%ChatPost{})
    socket = assign(socket, changeset: changeset, chat_posts: [])
   {:ok, socket, temporary_assigns: [chat_posts: []]}
  end

  def handle_event("create", %{"chat_post" => chat_post}, socket) do
    id = random_string()
    LiveViewChatWeb.Endpoint.broadcast_from(self(), @topic, "create", %{chat_post: chat_post, id: id})
    {:noreply, assign(socket, chat_posts: [chat_post], id: id)}
  end

  def handle_info(%{ event: "create", payload: %{chat_post: chat_post, id: id}}, socket) do
    {:noreply, assign(socket, chat_posts: [chat_post], id: id)}
  end

  def render(assigns) do
    ChatView.render("chat.html", assigns)
  end

  def random_string do
    alphabet = Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9)
    length = 12
    for _ <- 1..length, into: "", do: << Enum.random(alphabet) >>
  end

end