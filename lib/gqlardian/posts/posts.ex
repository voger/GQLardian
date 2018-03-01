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
end
