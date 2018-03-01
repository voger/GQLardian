defmodule GQLardianWeb.Schema.PostTypes do
  use Absinthe.Schema.Notation
  import Kronky.Payload

  alias GQLardianWeb.Resolvers


  # Payload objects
  payload_object(:create_post_return, :post)

  object :post_mutations do
    field :create_post, :create_post_return do
      arg :input, non_null(:create_post_input)
      resolve &Resolvers.Posts.create_post/3
      middleware &build_payload/2
    end
  end

  object :post do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :content, non_null(:string)
    field :created_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  input_object :create_post_input do
    field :title, non_null(:string)
    field :content, non_null(:string)
  end
end
