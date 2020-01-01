defmodule LiveViewChat.Chat.ChatPost do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_posts" do
    field :chat_post, :string

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:chat_post])
    |> validate_required([:chat_post])
  end
end
