defmodule GQLardian.Posts.Post do
  use Ecto.Schema

  import Ecto.Changeset
  alias GQLardian.Posts.{Post, PostStatus}
  alias GQLardian.Repo

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
    |> assoc_status(attrs)
  end

  def create_changeset(%Post{} = post, attrs) do
    post
    |> changeset(attrs)
    |> validate_required([:title, :content])
    # FIXME: must put author alsewhere
    |> put_change(:author_id, 1)
  end

  def update_changeset(%Post{} = post, attrs) do
    post
    |> changeset(attrs)
  end

  defp assoc_status(changeset, %{"status" => status}) do
    if status = get_status(status) do
      put_change(changeset, :status, status)
    else
      add_error(changeset, :status, "invalid")
    end
  end

  defp assoc_status(changeset, _attrs) do
    changeset
  end

  defp get_status(status) when is_binary(status) do
    Repo.get(PostStatus, status)
  end
end
