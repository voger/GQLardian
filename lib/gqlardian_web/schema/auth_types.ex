defmodule GQLardianWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  alias GQLardianWeb.Resolvers

  # import_types(GQLardianWeb.Schema.UserTypes)

  object :session_mutations do
    field :login, :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Auth.login/3)
    end
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
  end
end
