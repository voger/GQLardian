defmodule GQLardian.Posts.Post do
  use Ecto.Schema

  import Ecto.Changeset
  alias GQLardian.Posts.{Post, PostStatus}

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :status, PostStatus, references: :status, type: :string
    belongs_to :author, GQLardian.Accounts.User
    timestamps()
  end

  @doc false
  def create_changeset(%Post{} = post, attrs) do
    # Temporary
    post
    |> cast(attrs, [:title, :content])
    |> put_change(:author_id, 1)
  end
end
