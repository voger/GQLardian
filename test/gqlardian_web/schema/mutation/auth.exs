defmodule GQLardianWeb.Schema.Mutation.Auth do
  use GQLardianWeb.ConnCase, async: true

  setup do
    {:ok, user} = Fixtures.create_user()
    {:ok, %{user: user}}
  end

  @login_query """
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

    result = post(build_conn(), "/api", query: @login_query, variables: variables)
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
    result = post(build_conn(), "/api", query: @login_query, variables: variables)

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
    result = post(build_conn(), "/api", query: @login_query, variables: variables)

    assert json_response(result, 200) == error_result
  end

  @logout_query """
  mutation Logout{
    logout{
      success
      }
    }
  """
  test "logout makes token invalid", %{user: %{username: username}} do
    variables = %{
      username: username,
      password: "hunter2"
    }

    # Log in the user, grab the token
    conn = post(build_conn(), "/api", query: @login_query, variables: variables)
    <<token::binary>> = Kernel.get_in(json_response(conn, 200), ["data", "login", "token"])

    # Log out the user.
    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")
      |> post("/api", query: @logout_query)

    assert true =
             conn
             |> json_response(200)
             |> Kernel.get_in(["data", "logout", "success"])

    # Let's try again with the same token. This time should fail because the token is invalid
    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")
      |> post("/api", query: @logout_query)

    assert %{"message" => "invalid_token"} = json_response(conn, 401)
  end
end
