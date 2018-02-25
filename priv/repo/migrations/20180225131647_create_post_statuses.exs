defmodule GQLardian.Repo.Migrations.CreatePostStatuses do
  use Ecto.Migration

  def change do
    create table(:post_statuses, primary_key: false) do
      add :status, :string, primary_key: true
    end
  end
end
