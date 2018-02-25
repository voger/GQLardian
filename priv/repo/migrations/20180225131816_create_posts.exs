defmodule GQLardian.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :content, :text, null: false
      add :author, references(:users, on_delete: :delete_all, on_update: :update_all), null: false

      add :status,
          references(:post_statuses, on_update: :update_all, column: :status, type: :citext), null: false
    end
  end
end
