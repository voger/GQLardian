defmodule GQLardianWeb.Schema.Query.PostsTest do
  use GQLardianWeb.ConnCase, async: true

  setup do
    {:ok,
     list_posts:
       1..3
       |> Stream.map(fn _ ->
         {:ok, user} = Fixtures.create_user()
         Fixtures.create_post(user)
       end)
       |> Enum.to_list()}
  end

  test "the truth" do
    assert true
  end
end
