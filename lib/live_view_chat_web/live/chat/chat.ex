defmodule LiveViewChatWeb.ChatLive.Chat do
  use Phoenix.LiveView
  alias LiveViewChat.Chat
  alias LiveViewChat.Chat.ChatPost
  alias LiveViewChatWeb.ChatView
  alias LiveViewChatWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    IO.puts("--mount--")
    changeset = Chat.change_chat_post(%ChatPost{})
    socket = assign(socket, changeset: changeset, chat_posts: [])
   {:ok, socket, temporary_assigns: [chat_posts: []]}
  end

  def handle_event("create", %{"chat_post" => chat_post} = attr, socket) do
    IO.puts("--send--")
    IO.inspect(attr)
    id = random_string
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