defmodule GQLardianWeb.Resolvers.Posts do
  alias GQLardian.Posts
  alias GQLardian.Posts.Post

  def create_post(_, %{input: arguments}, _res) do
    with {:ok, %Post{} = post} <- Posts.create_post(arguments) do
      {:ok, post}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, changeset}
    end
  end
end
