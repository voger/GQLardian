defmodule GQLardianWeb.Schema.PostTypes do
  use Absinthe.Schema.Notation
  import Kronky.Payload

  alias GQLardianWeb.Resolvers

  object :post_queries do
    field :posts, list_of(:post) do
      resolve &Resolvers.Posts.posts/3
    end

    field :post, :post do
      arg :id, non_null(:id)
      resolve &Resolvers.Posts.get_post/3
    end
  end

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
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  input_object :create_post_input do
    field :title, non_null(:string)
    field :content, non_null(:string)
  end
end
