defmodule GQLardianWeb.Schema.Query.UsersTest do
  use GQLardianWeb.ConnCase, async: true

  setup do
    {:ok, user} = Fixtures.create_user()
    {:ok, user: user}
  end

  @query """
  query ListUsers($id: ID!) {
    user(id: $id) {
      id
      username
    }
  }
  """
  test "querying for user with id returns an existing user", %{user: user} do
    variables = %{"id" => user.id}
    response = get(build_conn(), "/api", query: @query, variables: variables)

    assert json_response(response, 200) == %{
             "data" => %{
               "user" => %{
                 "username" => user.username,
                 "id" => to_string(user.id)
               }
             }
           }
  end
end
