defmodule GQLardianWeb.Resolvers.Posts do
  alias GQLardian.Posts
  alias GQLardian.Posts.Post

  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def create_post(_, %{input: arguments}, %{context: %{current_user: user}} ) do
    {:ok, Posts.create_post(arguments, user)}
  end

  def get_post(_, %{id: id}, _res) do
    {:ok, Posts.get_post(id)}
  end

  def update_post(_, %{input: arguments}, _res) do
    with %Post{} = post <- Posts.get_post(arguments.id),
         {_, result} <- Posts.update_post(post, arguments) do
      {:ok, result}
    else
      nil ->
        {:ok, %Kronky.ValidationMessage{field: :id, message: "not found", code: :not_found}}
    end
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
