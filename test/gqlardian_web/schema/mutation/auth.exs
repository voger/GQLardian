defmodule GQLardianWeb.Schema.Mutation.Auth do
  use GQLardianWeb.ConnCase, async: true

  setup do
    {:ok, user} = Fixtures.create_user()
    {:ok, %{user: user}}
  end

  @query """
  mutation Login($username: String!, $password: String!) {
    login(username: $username, password: $password) {
      token
      user {
              username
              id
            }
    }
  }
  """
  test "loging in with correct credentials yelds proper result", %{
    user: %{username: username, id: id} = user
  } do
    variables = %{username: username, password: "hunter2"}

    result = post(build_conn(), "/api", query: @query, variables: variables)
    user_id = to_string(id)

    assert %{
             "data" => %{
               "login" => %{
                 "user" => %{
                   "username" => ^username,
                   "id" => ^user_id
                 },
                 "token" => token
               }
             }
           } = json_response(result, 200)

    assert {:ok, ^user, _} = GQLardian.Auth.Guardian.resource_from_token(token)
  end

  test "loging in with incorrect credentials rises graphql error", %{user: %{username: username}} do
    variables = %{username: username, password: "This_is a random password."}
    result = post(build_conn(), "/api", query: @query, variables: variables)

    error_result = %{
      "errors" => [
        %{
          "path" => [
            "login"
          ],
          "message" => "invalid username/password combination",
          "locations" => [
            %{
              "line" => 2,
              "column" => 0
            }
          ]
        }
      ],
      "data" => %{
        "login" => nil
      }
    }

    assert json_response(result, 200) == error_result

    variables = %{username: "morpheus", password: "hunter2"}
    result = post(build_conn(), "/api", query: @query, variables: variables)

    assert json_response(result, 200) == error_result
  end
end
