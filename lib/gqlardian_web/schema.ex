defmodule GQLardianWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.UserTypes
  import_types __MODULE__.PostTypes
  import_types __MODULE__.AuthTypes
  import_types __MODULE__.ValidationMessageTypes

  import_types Absinthe.Type.Custom

  query do
    import_fields :user_queries
    import_fields :post_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :post_mutations
    import_fields :session_mutations
  end

  def dataloader() do
    Dataloader.new()
    |> Dataloader.add_source(:generic, data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  def data() do
    Dataloader.Ecto.new(GQLardian.Repo)
  end
end
