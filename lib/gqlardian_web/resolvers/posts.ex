defmodule GQLardianWeb.Resolvers.Posts do
  alias GQLardian.Posts
  alias GQLardian.Posts.Post

  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def create_post(_, %{input: arguments}, _res) do
    {:ok,Posts.create_post(arguments)}
  end

  def get_post(_, %{id: id}, _res) do
    {:ok, Posts.get_post(id)}
  end

  def update_post(_, %{input: arguments}, _res) do
    {:ok, Posts.update_post(arguments.id, arguments)}
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
