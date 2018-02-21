defmodule GQLardianWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.UserTypes

  query do
    import_fields :user_queries 
  end


end
