defmodule GQLardian.Posts.Post do
  use Ecto.Schema

  import Ecto.Changeset
  alias GQLardian.Posts.{Post, PostStatus}
  alias GQLardian.Repo

  # FIXME: This should be taken from config or db or something else
  @default_post_status "draft"

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :status, PostStatus, references: :status, type: :string, on_replace: :nilify
    belongs_to :author, GQLardian.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    # Temporary
    post
    |> cast(attrs, [:title, :content])
  end

  def create_changeset(%Post{} = post, attrs) do
    post
    |> changeset(attrs)
    |> validate_required([:title, :content])
    |> change_status(@default_post_status)
    # FIXME: must put author alsewhere
    |> put_change(:author_id, 1)
  end

  def update_changeset(%Post{} = post, %{"status" => status} = attrs) when is_binary(status) do
    post
    |> update_changeset(Map.delete(attrs, "status"))
    |> change_status(status)
    |> assoc_constraint(:status)
  end

  def update_changeset(%Post{} = post, attrs) do
    post
    |> changeset(attrs)
  end

  defp change_status(changeset, status) when is_binary(status) do
    put_change(changeset, :status_id, status)
  end
end
