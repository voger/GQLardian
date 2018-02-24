defmodule GQLardian.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :citext
      add :password_hash, :string

      timestamps()
    end

  end
end
