defmodule GQLardian.Posts do
  @moduledoc """
  The Posts context
  """

  alias GQLardian.Repo
  alias GQLardian.Posts.Post

  def create_post(attrs) do
    %Post{}
    |> Post.create_changeset(attrs)
    |> Repo.insert!()
  end

  def update_post(post_id, attrs \\ %{}) do
    with post = %Post{} <- get_post(post_id) do
      post
      |> Post.update_changeset(attrs)
      |> Repo.update!()
    else
      nil ->
        %Kronky.ValidationMessage{field: :id, message: "not found", code: :not_found}
    end
  end

  def get_post(id) do
    Repo.get(Post, id)
  end

  def list_posts() do
    Repo.all(Post)
  end
end
