defmodule LiveViewChat.Repo.Migrations.CreateChatPosts do
  use Ecto.Migration

  def change do
    create table(:chat_posts) do
      add :chat_post, :string

      timestamps()
    end

  end
end
