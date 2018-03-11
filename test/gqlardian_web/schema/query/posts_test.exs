defmodule GQLardianWeb.Schema.Query.PostsTest do
  use GQLardianWeb.ConnCase, async: true

  require Cl

  setup do
    1..3
    |> Stream.map(fn _ ->
      Fixtures.create_post() |> GQLardian.Posts.create_post()
    end)
    |> Enum.to_list()
    |> Cl.inspect(label: "-b list of posts")
  end

  test "the truth" do
    assert 1 + 1
  end
end
