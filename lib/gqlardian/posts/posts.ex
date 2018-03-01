defmodule GQLardian.Posts do
  @moduledoc """
  The Posts context
  """

  alias GQLardian.Repo
  alias GQLardian.Posts.{Post, PostStatus}

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.create_changeset(attrs)
    |> Repo.insert()
  end

  def get_post(id) do
    Repo.get(Post, id)
  end

  def list_posts() do
    Repo.all(Post)
  end
end
