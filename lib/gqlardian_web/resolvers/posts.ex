defmodule GQLardianWeb.Resolvers.Posts do
  alias GQLardian.Posts
  alias GQLardian.Posts.Post

  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def create_post(_, %{input: arguments}, _res) do
    with {:ok, %Post{} = post} <- Posts.create_post(arguments) do
      {:ok, post}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, changeset}
    end
  end

  def get_post(_, %{id: id}, _res) do
    {:ok, Posts.get_poszt(id)}
  end

  def posts(_, _, _) do
    {:ok, Posts.list_posts()}
  end

  def status_for_posts(parent, _, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(:generic, :status, parent)
    |> on_load(fn loader ->
      status =
        loader
        |> Dataloader.get(:generic, :status, parent)
        |> Map.fetch!(:status)

      {:ok, status}
    end)
  end
end
