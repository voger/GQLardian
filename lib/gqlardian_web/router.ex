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

    forward("/api", Absinthe.Plug, schema: GQLardianWeb.Schema)
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
end
