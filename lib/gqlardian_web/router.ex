defmodule GQLardianWeb.Router do
  use GQLardianWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(GQLardianWeb.Pipelines.AuthPipeline)
    plug(GQLardianWeb.Plug.UserInContext)
  end

  scope "/" do
    pipe_through([:api, :jwt_authenticated])

    forward(
      "/api",
      Absinthe.Plug,
      schema: GQLardianWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send}
    )
  end

  scope "/" do
    pipe_through(:api)

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: GQLardianWeb.Schema,
      socket: GQLardianWeb.UserSocket
    )
  end

  # Just in case, perform a total guardian signout
  def absinthe_before_send(conn, %{result: %{data: %{"logout" => %{"success" => true}}}}) do
    GQLardian.Auth.Guardian.Plug.sign_out(conn)
  end


  def absinthe_before_send(conn, _) do
    conn
  end
end
