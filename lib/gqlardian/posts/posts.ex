defmodule GQLardian.Posts do
  @moduledoc """
  The Posts context
  """

  # FIXME: This should be taken from config or db or something else
  @default_post_status "daft"

  alias GQLardian.Repo
  alias GQLardian.Posts.Post

  def create_post(attrs) do
    attrs = Map.put(attrs, "status", @default_post_status)

    %Post{}
    |> Post.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_post(post_id, attrs \\ %{}) do
    post_id
    |> get_post()
    |> Repo.preload(:status)
    |> Post.update_changeset(attrs)
    |> Repo.update!()
  end

  def get_post(id) do
    Repo.get(Post, id)
  end

  def list_posts() do
    Repo.all(Post)
  end
end
