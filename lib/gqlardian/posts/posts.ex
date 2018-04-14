defmodule GQLardian.Posts do
  @moduledoc """
  The Posts context
  """

  alias GQLardian.Repo
  alias GQLardian.Posts.Post

  require Cl

  def create_post(attrs, user) do
    user
    |> Ecto.build_assoc(:posts)
    |> Cl.inspect(label: "-b post struct")
    |> Post.create_changeset(attrs)
    |> Repo.insert!()
  end

  def update_post(%Post{} = post, attrs \\ %{}) do
    post
    |> Post.update_changeset(attrs)
    |> Repo.update()
  end

  def get_post(id) do
    Repo.get(Post, id)
  end

  def list_posts() do
    Repo.all(Post)
  end
end
