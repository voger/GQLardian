defmodule GQLardianWeb.Schema.Mutation.TokenTest do
  use GQLardianWeb.ConnCase, async: true
  alias GQLardian.Auth.Guardian
  require Cl

  @query """
  query GetUser($id: ID!) {
    user(id: $id) {
      id
      username
    }
  }
  """

  describe "with valid token" do
    setup do
      with {:ok, user} = Fixtures.create_user(),
           {:ok, token, _claims} = Guardian.encode_and_sign(user) do
        [user: user, token: token]
      end
    end

    # @tag :skip
    test "returns proper response from query", %{user: user, token: token} do
      variables = %{"id" => user.id}

      conn = create_the_conn(token, @query, variables)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "user" => %{
                   "id" => to_string(user.id),
                   "username" => user.username
                 }
               }
             }
    end

    # @tag :skip
    test "without user returns nil", %{user: user, token: token} do
      # query for nonexisting user
      variables = %{"id" => user.id + 1}

      conn = create_the_conn(token, @query, variables)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "user" => nil
               }
             }
    end
  end

  describe "with invalid token" do
    setup do
      {:ok, user} = Fixtures.create_user()
      %{user: user}
    end

    # @tag :skip
    test "expired token returns error", %{user: user} do
      # token has expired 5 minutes ago
      minutes_before = 5
      ttl = {-minutes_before, :minutes}

      {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: ttl)

      variables = %{"id" => user.id}
      conn = create_the_conn(token, @query, variables)

      assert "{\"message\":\"invalid_token\"}" = response(conn, 401)
    end

    test "unexistent sub returns error", %{user: user} do
      user = %{user | id: user.id + 1}
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      variables = %{"id" => user.id}

      conn = create_the_conn(token, @query, variables)

      assert "{\"message\":\"no_resource_found\"}" = response(conn, 401)
    end
  end

  defp create_the_conn(token, query, variables) do
    build_conn()
    |> put_req_header("authorization", "Bearer #{token}")
    |> post("/api", query: query, variables: variables)
  end
end
