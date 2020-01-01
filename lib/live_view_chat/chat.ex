defmodule LiveViewChat.Chat do
  alias LiveViewChat.Chat.ChatPost
  alias  LiveViewChat.Repo
  import Ecto.Query


  @doc """
  Create a changeset to change a chat_post
  """
  def change_chat_post(chat_post, changes \\%{}) do
    ChatPost.changeset(chat_post, changes)
  end

end