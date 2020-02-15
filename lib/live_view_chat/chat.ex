defmodule LiveViewChat.Chat do
  alias LiveViewChat.Chat.ChatPost

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

end