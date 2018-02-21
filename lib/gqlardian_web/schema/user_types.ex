defmodule GQLardianWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  object :user_queries do
    field :user, :user
  end

  object :user do
    field :id, non_null(:id)
    field :username, non_null(:string)
  end
end
