defmodule GQLardian.Posts.Post do
  use Ecto.Schema

  import Ecto.Changeset
  alias GQLardian.Posts.{Post, PostStatus}

  # FIXME: This should be taken from config or db or something else
  @default_post_status "draft"

  schema "posts" do
    field(:title, :string)
    field(:content, :string)

    belongs_to(
      :status,
      PostStatus,
      references: :status,
      type: :string,
      on_replace: :nilify
    )

    belongs_to(:author, GQLardian.Accounts.User, type: GQLardian.EctoTypes.Hashid)
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
    |> change_status(%{status: @default_post_status})
  end

  def update_changeset(%Post{} = post, attrs) do
    post
    |> changeset(attrs)
    |> change_status(attrs)
    |> assoc_constraint(:status)
  end
  require Cl

  defp change_status(changeset, %{status: status}) do
    Cl.inspect(status, label: "-b putting status")
    put_change(changeset, :status_id, to_string(status))
  end

  defp change_status(changeset, _attrs) do
    changeset
  end
end
