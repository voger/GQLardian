defmodule GQLardianWeb.Schema.Mutation.UserMutationsTest do
  use GQLardianWeb.ConnCase, async: true
  alias GQLardian.Auth.Guardian

  @query """
  mutation CreateUser($input: CreateUserInput!){
    createUser(input: $input){
      messages {
        code
        field
        message
      },
      result {
        id
        username
      },
      successful
    }
  }
  """
  @variables """
  {
    "input": {
      "password": "hunter2",
      "username": "AzureDiamond"
    }
  }
  """
  @tag :skip
  test "create user creates a user" do
    conn = post(build_conn(), "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "createUser" => %{
                 "successful" => true,
                 "result" => %{
                   "username" => "AzureDiamond",
                   "id" => _
                 },
                 "messages" => []
               }
             }
           } = json_response(conn, 200)
  end

  @tag :skip
  test "create user with the same username fails with error" do
    GQLardian.Accounts.create_user(%{username: "AzureDiamond", password: "hunter2"})

    conn = post(build_conn(), "/api", query: @query, variables: @variables)

    assert %{
             "data" => %{
               "createUser" => %{
                 "successful" => false,
                 "result" => nil,
                 "messages" => [
                   %{
                     "message" => "already taken",
                     "field" => "username",
                     "code" => "unknown"
                   }
                 ]
               }
             }
           } = json_response(conn, 200)
  end

end
