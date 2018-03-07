defmodule GQLardian.Posts do
  @moduledoc """
  The Posts context
  """


  alias GQLardian.Repo
  alias GQLardian.Posts.Post

  def create_post(attrs) do
    %Post{}
    |> Post.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_post(post_id, attrs \\ %{}) do
    post_id
    |> get_post()
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
