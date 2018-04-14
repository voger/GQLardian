defmodule GQLardianWeb.Schema.Query.PostsTest do
  use GQLardianWeb.ConnCase, async: true

  require Cl

  setup do
    1..3
    |> Stream.map(fn _ ->
      {:ok, user} = Fixtures.create_user()
      Fixtures.create_post(user)
    end)
    |> Enum.to_list()
    |> Cl.inspect(label: "-b list of posts")
  end

  test "the truth" do
    assert true
  end
end
