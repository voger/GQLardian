defmodule GQLardianWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  alias GQLardianWeb.Resolvers

  object :session_mutations do
    field :login, :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Auth.login/3)
    end

    field :logout, :logout_return do
      resolve(&Resolvers.Auth.logout/3)
    end
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
  end

  object :logout_return do
    field(:success, :boolean)
  end
end
