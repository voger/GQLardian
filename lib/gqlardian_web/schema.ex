defmodule GQLardianWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.UserTypes

  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
  end
end
