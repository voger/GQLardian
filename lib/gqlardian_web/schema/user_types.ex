defmodule GQLardianWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  alias GQLardianWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.get_user/3
    end
  end

  object :user_mutations do
    field :create_user, :user do
      arg :input, non_null(:create_user_input)


    end
  end

  object :user do
    field :id, non_null(:id)
    field :username, non_null(:string)
  end

  input_object :create_user_input do
    field :username, :string
    field :password, :string
  end
end
