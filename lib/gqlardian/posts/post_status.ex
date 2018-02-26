defmodule GQLardian.Posts.PostStatus do
  use Ecto.Schema

  @primary_key {:status, :string, autogenerate: false}
  schema "post_statuses" do
  end
  
end
