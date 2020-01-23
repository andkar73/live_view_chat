defmodule LiveViewChat.Chat do
  alias LiveViewChat.Chat.ChatPost
  alias LiveViewChatWeb.Presence

  @doc """
  Create a changeset to change a chat_post.
  Returns a changeset.
  """
  def change_chat_post(chat_post, changes \\%{}) do
    ChatPost.changeset(chat_post, changes)
  end

  @doc """
  Create a random string containing letters and numbers.
  Returns a string
  """
  def random_string do
    alphabet = Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9)
    length = 12
    for _ <- 1..length, into: "", do: << Enum.random(alphabet) >>
  end

  @doc """
  Returns the number of user assigned to a topic.
  """
  def number_of_users(topic) do
    %{"user" => %{metas: user_list}} = Presence.list(topic)
    length(user_list)
  end

end