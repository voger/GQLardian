defmodule GQLardianWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.UserTypes
  import_types __MODULE__.PostTypes
  import_types __MODULE__.ValidationMessageTypes

  import_types Absinthe.Type.Custom

  query do
    import_fields :user_queries
    import_fields :post_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :post_mutations
  end
end
